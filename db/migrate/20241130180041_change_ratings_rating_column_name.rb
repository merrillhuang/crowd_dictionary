class ChangeRatingsRatingColumnName < ActiveRecord::Migration[7.1]
  def change
    rename_column(:ratings, :rating, :rating_val)
  end
end
