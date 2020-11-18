class User < ApplicationRecord
  rolify
  has_and_belongs_to_many :games
  after_create :assign_default_role
  has_one_attached :picture, dependent: :purge
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable
       
  validates :username, :email, presence: true, uniqueness: true
  validates :picture, content_type: [:png, :jpg, :jpeg]

  def assign_default_role
    self.add_role(:public) if self.roles.blank?
  end
end
