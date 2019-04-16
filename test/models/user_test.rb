require 'test_helper'

class UserTest < ActiveSupport::TestCase
=begin
  Userモデルの単体テストクラス
=end
  def setup
    @user         = users(:testuser)
    @user_followed = users(:testuser2) 
  end

  test "should be possible to follow and unfollow user" do
    #初期段階でフォローしていない
    assert_not @user.following?(@user_followed)
    #ユーザをフォロー
    @user.follow!(@user_followed)
    #フォローしていることを確認
    assert @user.following?(@user_followed)

    #アンフォロー
    @user.unfollow!(@user_followed)
    assert_not @user.following?(@user_followed)
  end
end

