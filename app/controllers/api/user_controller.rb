module Api
    class Api::UserController < ApplicationController
        protect_from_forgery with: :null_session
        before_action :authenticate_api_user!

        def index
            @user  = current_api_user
            
            # タスク一覧
            @todos     = @user.todos
            # グラフ描画用データ
            @complete_todos_groupby = @user.todos.where(cleared:true).group('title').count
            @return_json_data = {todos: @todos.where(cleared:false), graphdata: @complete_todos_groupby}
            render :json => @return_json_data
        end

        def show

        end
    end
end