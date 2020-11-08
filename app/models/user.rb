class User < ApplicationRecord
  rolify
  after_create :assign_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable
       
  has_one_attached :profile_picture, dependent: :destroy
  validates :username, :email, presence: true, uniqueness: true
  validates :profile_picture, content_type: [:png, :jpg, :jpeg]


  def assign_default_role
    self.add_role(:public) if self.roles.blank?
  end
end
