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
            # 取得するユーザIDを取得
            id = params[:id]
            if id=="own" then
                show_current_user
            else
                @user = User.find(params[:id])
                render :json => @user
            end
        end

        def follow
            @user = current_api_user
            follow_user = User.find(follow_user_params[:user_id])
            if @user.following?(follow_user)
                @return_json_data = {mes: "すでにフォローしています"}
                render :json => @return_json_data, status: 422
            else @user.follow!(follow_user)
                if @user.save
                    @return_json_data = {'follow': follow_user}
                    render  :json => @return_json_data, status: 200
                else
                    @return_json_data = {mes: "フォローに失敗しました"}
                    render :json => @return_json_data, status: 422
                end
            end
        end

        def unfollow
            @user = current_api_user
            unfollow_user = User.find(follow_user_params[:user_id])
            if @user.following?(unfollow_user)
                @user.unfollow!(unfollow_user)
                if @user.save
                    @return_json_data = {'unfollow': unfollow_user}
                    render :json => @return_json_data, status: 200
                else
                    @return_json_data = {mes: "失敗しました"}
                    render :json => @return_json_data, status: 422
                end
            else
                @return_json_data = {mes: "フォローしていません"}
                render :json => @return_json_data, status: 422
            end
        end

        private
        def show_current_user
            #ログインしているユーザ情報
            @user     = current_api_user
            @return_json_data = {user: @user, posts: @user.posts, following: @user.followings, follower: @user.followers }
            render :json => @return_json_data
        end

        def follow_user_params
            params.require(:user).permit(:user_id)
        end
    end
end