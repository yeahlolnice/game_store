class Game < ApplicationRecord
  has_and_belongs_to_many :users
  has_one_attached :picture, dependent: :destroy
  has_one_attached :game_folder
 
 # validates picture type and that all fields have been filled
  validates :picture, content_type: [:png, :jpg, :jpeg]
  validates :game_folder, content_type: [:zip]
  validates_presence_of :title, :picture, :description, :price, :game_folder
  validates_uniqueness_of :title
end
