class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts
  has_many :todos,foreign_key: 'users_id'
  accepts_nested_attributes_for :todos
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
