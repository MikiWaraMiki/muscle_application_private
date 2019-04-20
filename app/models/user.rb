class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts, foreign_key:'users_id'
  has_many :todos,foreign_key: 'users_id'
  # フォロワーの関係についてRelationshipsテーブルと1:nの関係をもつ
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  # following_relationshipsを介して複数のフォローをもつ
  has_many :followings, through: :following_relationships
  # フォローしている関係についてRelationshipsテーブルと1:nの関係をもつ
  has_many :follower_relationships, foreign_key:"following_id", class_name: "Relationship", dependent: :destroy
  # follower_relationshipsを介して複数のフォロワーをもつ
  has_many :followers, through: :follower_relationships

  accepts_nested_attributes_for :todos
  accepts_nested_attributes_for :posts

  #Device is
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  

  # タイムラインからフォローする際の処理
  # タイムラインを投稿しているユーザが自分自身の場合trueを返す。それ以外の場合はfalseを返す
  def following_user_is_own?(other_user)
    self.id == other_user.id
  end

  #ユーザをフォローしているか?
  def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
  end

  #ユーザのフォロー処理
  def follow!(other_user)
    following_relationships.create!(following_id: other_user.id, follower_id: self.id)
  end

  #ユーザのフォロー解除
  def unfollow!(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end

end
