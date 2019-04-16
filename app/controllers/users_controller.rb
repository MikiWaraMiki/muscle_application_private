class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def new
    @user = User.new
  end

  def show
    @user  = current_user
    @todo  = Todo.new
    #完了済みToDoのみを取得
    @user_todo_list = @user.todos.where(cleared: false);
  end

  def show_timeline
    @user      = current_user
    #自分のタイムライン
    @posts     = @user.posts.order(:created_at).paginate(per_page:4, page: params[:user_timeline_page])
    #全ユーザタイムライン
    @all_posts = Post.all.order(:created_at).paginate(per_page:4, page: params[:all_user_timeline_page])
    render template: "users/show_timeline"
  end
 
  private
    def user_params
      params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end

    def todo_params
      params.require(:user).permit(todos_attributes: [:wight, :count, :complete_date])
    end
end
