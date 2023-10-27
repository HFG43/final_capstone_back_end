class CreateExperiences < ActiveRecord::Migration[7.0]
  def change
    create_table :experiences do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.decimal :experience_fee, null: false
      t.decimal :add_testing_fee, null: false
      t.decimal :reserve_full_table, null: false
      t.integer :guests, null: false

      t.timestamps
    end
  end
end
