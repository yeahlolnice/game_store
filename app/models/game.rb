class Game < ApplicationRecord
  has_and_belongs_to_many :users
  has_one_attached :picture, dependent: :destroy

  validates :picture, content_type: [:png, :jpg, :jpeg]
  
end
