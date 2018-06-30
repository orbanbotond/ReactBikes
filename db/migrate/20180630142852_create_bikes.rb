class CreateBikes < ActiveRecord::Migration[5.1]
  def change
    create_table :bikes do |t|
      t.string :color
      t.string :weight
      t.decimal :latitude
      t.decimal :longitude
      t.references :bike_model, foreign_key: true

      t.timestamps
    end
  end
end
