require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
    get "/signup"
    assert_no_difference "User.count" do
      post "/signup", params:{user:{
        name:"",
        email:"user@valid",
        password:"sample",
        password_confirmation:"bar"
      }}
    end
    assert_template "users/new"
    #エラーメッセージが表示されていることを確認する
    assert_select 'div.alert'
  end

  test "valid signup information" do
    get signup_path
    assert_difference "User.count", 1 do
      post signup_path, params:{user:{
        name:"testuser",
        email:"test@gmail.com",
        password:"password",
        password_confirmation:"password"
      }
    }
    end
    follow_redirect!
    assert_template "users/show"
    assert_select 'div.alert-success'
    assert_not flash.empty?()
    assert is_logged_in?
  end
end
