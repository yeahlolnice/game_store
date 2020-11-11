class AddPriceToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :price, :integer
  end
end
