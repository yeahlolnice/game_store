class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.string :title
      t.text :content
      t.float :rating
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
