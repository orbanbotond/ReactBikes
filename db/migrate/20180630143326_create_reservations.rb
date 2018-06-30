class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :rating, default: nil
      t.boolean :cancelled, default: false
      t.references :user, foreign_key: true
      t.references :bike, foreign_key: true

      t.timestamps
    end
  end
end
