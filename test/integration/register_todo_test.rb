require 'test_helper'

class RegisterTodoTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers 
  def setup
    Warden.test_mode!
    @user = users(:testuser)
    @todo = todos(:testtodo)
    login_as(@user, :scope => :user)
  end

  test "should be show user top page after success login" do
    
    get  user_url(@user)
    assert_template 'users/show'
    assert_select 'h1', "Welcome #{@user.name} !!"
    
    post todos_url,xhr:true,  params:{
      todo:{
        title: @todo.title,
        weight: @todo.weight,
        set_count: @todo.set_count,
        clear_plan: @todo.clear_plan
      }
    }
    
    json = JSON.parse(response.body)['data']
    assert json['title'], @todo.title
    assert json['weight'], @todo.weight
    assert json['set_count'], @todo.set_count
    assert json['clear_plan'], @todo.clear_plan
    assert_difference "Todo.count", 1 do
      post todos_url,xhr:true,  params:{
        todo:{
          title: @todo.title,
          weight: @todo.weight,
          set_count: @todo.set_count,
          clear_plan: @todo.clear_plan
        }
      }
    end
  end

  test 'comleted task should be changed cleared status is true ' do
    get user_url(@user)
    post todos_url,xhr:true,  params:{
      todo:{
        title: @todo.title,
        weight: @todo.weight,
        set_count: @todo.set_count,
        clear_plan: @todo.clear_plan
      }
    }
    assert_response :success
    patch complete_todo_path(@todo), xhr: true
    assert_response :success
    json = JSON.parse(response.body)['flash']
    assert json, "更新が完了しました"
    assert_select 'div.alert', "更新が完了しました"
  end

end
