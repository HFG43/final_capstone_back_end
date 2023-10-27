class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.references :users, null: false, foreign_key: { to_table: :users }
      t.references :experiences, null: false, foreign_key: { to_table: :experiences }
      t.datetime :date, null: false
      t.string :city, null: false

      t.timestamps
    end
  end
end
