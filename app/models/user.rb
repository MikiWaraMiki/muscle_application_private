# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  has_many :todos, foreign_key: 'users_id'
  has_many :posts, foreign_key: 'users_id'
  validates  :name, presence: true, on: :create

  # フォロワーの関係についてRelationshipsテーブルと1:nの関係をもつ
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship"
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  # following_relationshipsを介して複数のフォローをもつ
  has_many :followings, through: :following_relationships
  # フォローしている関係についてRelationshipsテーブルと1:nの関係をもつ
  has_many :follower_relationships, foreign_key:"following_id", class_name: "Relationship"
  has_many :follower_relationships, foreign_key:"following_id", class_name: "Relationship", dependent: :destroy
  # follower_relationshipsを介して複数のフォロワーをもつ
  has_many :followers, through: :follower_relationships

  def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
  end
  def follow!(other_user)
    following_relationships.create!(following_id: other_user.id, follower_id: self.id)
  end

  def unfollow!(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end

end
