class Cat < ApplicationRecord
  include AASM

  validates :name, presence: true

  aasm do
    state :idle, initial: true
    state :meowing
    state :playing
    state :tired
    state :sleeping

    event :meow, before: Proc.new { use_stamina(1) } do
      transitions from: [:idle, :playing], to: :meowing, guard: :has_stamina?
    end

    event :play, before: Proc.new { use_stamina(3) } do
      transitions from: [:idle, :meowing], to: :playing, guard: :has_stamina?
    end

    event :stop do
      transitions from: [:meowing, :playing],
                  to: :idle
    end

    event :wakeup do
      transitions from: :sleeping, to: :idle, after: :replenish_stamina
    end

    event :rest do
      transitions from: [:idle, :tired], to: :sleeping
    end
  end

  def has_stamina?
    stamina >= 0
  end

  def use_stamina(amount)
    self.stamina = stamina - amount
    p "THIS IS AMERICA"
  end

  def replenish_stamina
    self.stamina = 10
  end
end
