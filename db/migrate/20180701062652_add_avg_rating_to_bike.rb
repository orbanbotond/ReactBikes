class AddAvgRatingToBike < ActiveRecord::Migration[5.1]
  def change
    add_column :bikes, :average_rating, :decimal, default: 0
  end
end
