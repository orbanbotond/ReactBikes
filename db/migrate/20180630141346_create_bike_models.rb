class CreateBikeModels < ActiveRecord::Migration[5.1]
  def change
    create_table :bike_models do |t|
      t.string :text

      t.timestamps
    end
  end
end
