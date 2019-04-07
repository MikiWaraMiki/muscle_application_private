class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def new
    @user = User.new
  end

  def show
    @user  = current_user
    @todo  = Todo.new
  end
 
  private
    def user_params
      params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end

    def todo_params
      params.require(:user).permit(todos_attributes: [:wight, :count, :complete_date])
    end
end
