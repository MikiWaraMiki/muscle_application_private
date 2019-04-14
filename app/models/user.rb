class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts, foreign_key:'users_id'
  has_many :todos,foreign_key: 'users_id'
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship"
  has_many :followings, through: :following_relationships
  has_many :follower_relationships, foreign_key:"following_id", class_name: "Relationship"
  has_many :followers, through: :follower_relationships
  accepts_nested_attributes_for :todos
  accepts_nested_attributes_for :posts
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
  end

  def follow!(other_user)
    following_relationships.create!(following_id: other_user.id)
  end

  def unfollow!(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end

end
