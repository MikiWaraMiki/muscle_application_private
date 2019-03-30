require 'test_helper'

class UserTest < ActiveSupport::TestCase
=begin
  Userモデルの単体テストクラス
=end
  def setup
    @user = User.new(name:"TEST", email:"test@test.com", password:"password", password_confirmation:"password")
  end

  test "valid data" do
=begin
    正常な入力の場合、Userオブジェクトは有効である
=end
    assert @user.valid?
  end
  test "name should be present" do
=begin
    nameが入力されていない、または空白の場合には、検証に失敗する
=end
    @user.name = "   "
    assert_not @user.valid?
  end

  test "name should be less than 17" do
=begin
    名前は17文字以下でなければならない
=end
    @user.name = "a" * 18
    assert_not @user.valid?
  end

  test "email should be present" do
=begin
    メールアドレスは入力されていなければならない
=end
    @user.email = " "
    assert_not @user.valid?
  end

  test "email should be less than 100" do
=begin
    メールアドレスは100文字以下でなければならない
=end
    @user.email = "a"*101
    assert_not @user.valid?
  end
  test "email should be valid format" do
=begin
    正しいメールアドレスが入力された場合は登録されなければならない
=end
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do | valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{@user.email} shold be valid"
    end
  end
  test "invalid email format" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do | invalid_address |
      @user.email = invalid_address
      assert_not @user.valid?, "#{@user.email} should be invalid"
    end
  end
  
  test "email address should be invalid" do
    #@userと同じオブジェクトを作成
    copy_user = @user.dup
    @user.save
    copy_user.email.upcase
    assert_not copy_user.valid?
  end

  test "password should be present(no blank)" do
    @user.password = @user.password_confirmation = " "*6
    assert_not @user.valid?
  end

  test "password_confimation should be equal password" do
    @user.password_confirmation = "valid_password"
    assert_not @user.valid?
  end

  test "password legnth should be more than 8 characters" do
    @user.password = @user.password_confirmation = "a"*6
    assert_not @user.valid?
  end
end

