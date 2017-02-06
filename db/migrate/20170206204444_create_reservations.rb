class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.references :user, index: true, foreign_key: true
      t.references :experience, index: true, foreign_key: true
      t.datetime :reservation_date
      t.integer :price
      t.integer :total

      t.timestamps null: false
    end
  end
end
