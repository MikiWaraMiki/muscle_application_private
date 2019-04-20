require 'test_helper'

class RelationshipsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user       = users(:testuser)
    @other_user = users(:testuser2) 
    login_as(@user, :socpe => :user)
  end

  test "follwoing user from ajax" do
    assert_difference "Relationship.count", 1 do
      post following_path,xhr:true, params:{
        relationship:{
          following_id: @other_user.id
        }
      }
    end
  end

  test "Already following user should be return" do
    @user.follow!(@other_user)
    assert_no_difference "Relationship.count" do
      post following_path, xhr: true, params:{
        relationship:{
          following_id: @other_user.id
        }
      }
    end
    assert_response :unprocessable_entity
  end
end
