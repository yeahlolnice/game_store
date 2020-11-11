class AddOwnerToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :owner, :string
  end
end
