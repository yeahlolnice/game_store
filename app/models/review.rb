class Review < ApplicationRecord
  belongs_to :game

  validates_presence_of :title, :content, :rating
end
