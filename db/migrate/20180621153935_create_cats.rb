class CreateCats < ActiveRecord::Migration[5.2]
  def change
    create_table :cats do |t|
      t.string :name, null: false
      t.string :aasm_state
      t.integer :stamina, default: 10, null: false

      t.timestamps
    end
  end
end
