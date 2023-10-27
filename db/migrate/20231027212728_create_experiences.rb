class CreateExperiences < ActiveRecord::Migration[7.0]
  def change
    create_table :experiences do |t|
      t.string :name
      t.text :description
      t.decimal :experience_fee
      t.decimal :add_testing_fee
      t.decimal :reserve_full_table
      t.integer :guests

      t.timestamps
    end
  end
end
