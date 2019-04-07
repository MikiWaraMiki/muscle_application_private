require 'test_helper'

class TodoTest < ActiveSupport::TestCase
  def setup
    @todo = todos(:testtodo)
  end

  test "valid todo data should be registered" do
    #正当な入力をされている場合は登録できる
    assert @todo.valid?
  end

  test "todo data without title should not be registered" do
    @todo.title = ""
    assert_not @todo.valid?
  end

  test "todo data without set_count should not be registered" do
    @todo.set_count = "";
    assert_not @todo.valid?
  end

  test "todo data without weight should not be registered" do 
    @todo.weight = "";
    assert_not @todo.valid?
  end

  test "todo data of weight that is less than 1" do
    @todo.weight = 0;
    assert_not @todo.valid?
    @todo.weight = 10;
    @todo.set_count = 0;
    assert_not @todo.valid?
  end

  test "clear_plan should be later than Today" do
    @todo.clear_plan = "2019-03-12"
    assert_not @todo.valid?
  end
end
