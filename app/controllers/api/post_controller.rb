module Api
    class Api::PostController < ApplicationController
        before_action :authenticate_api_user!, except: [:index]
        protect_from_forgery with: :null_session

        PER=5

        def index
            #全てのtimelineを取得する
            puts "page is #{params}"
            posts = Post.all.order("created_at DESC").includes([:user,:todo]).page(params[:page]).per(PER)
            render json: posts.to_json(:include => [:user, :todo])
        rescue => error
            puts error
            render json: {message: "取得に失敗"},status: 500
        end
        def create
            post = current_api_user.posts.build(timeline_params)
            post.todo.posted = true
            post.todo.clear_date = complete_todos[:clear_date]
            post.todo.cleared    = true
            puts post.todo.inspect
            post.todo.save!
            if post.save!
                @return_json = {todo: post.todo}
                render json: @return_json, status:200
            end
        rescue => error
            puts error.class
            puts error.message
            puts error.backtrace
            puts post.inspect
            render json: {message: "シェアが失敗しました",errors: post.errors.full_messages},status: 500
        end
    
        private
        def timeline_params
            params.require(:post).permit(:comment,:todos_id)
        end
        def complete_todos
            params.require(:todo).permit(:clear_date)
        end
    end
end
