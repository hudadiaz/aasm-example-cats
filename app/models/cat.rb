class Cat < ApplicationRecord
  include AASM

  validates :name, presence: true

  aasm do
    state :idle, initial: true
    state :meowing
    state :playing
    state :sleeping

    event :meow, after: Proc.new { use_stamina(1) } do
      transitions from: %i[idle playing],
                  to: %i[meowing],
                  guard: Proc.new { has_stamina?(1) }
    end

    event :play, after: Proc.new { use_stamina(3) } do
      transitions from: %i[idle meowing],
                  to: %i[playing],
                  guard: Proc.new { has_stamina?(3) }
    end

    event :stop do
      transitions from: %i[meowing playing],
                  to: %i[idle]
    end

    event :wakeup do
      transitions from: %i[sleeping],
                  to: %i[idle],
                  after: %i[replenish_stamina]
    end

    event :rest do
      transitions from: %i[idle meowing playing],
                  to: %i[sleeping]
    end
  end

  def has_stamina?(amount = 1)
    return false if stamina.zero?
    stamina >= amount
  end

  def use_stamina(amount = 1)
    self.stamina = stamina - amount
    save
  end

  def replenish_stamina
    self.stamina = 10
  end
end
