module Api
    class Api::PostController < ApplicationController
        before_action :authenticate_api_user!
        protect_from_forgery with: :null_session
        def create
            post = current_api_user.posts.build(timeline_params)
            post.todo.posted = true
            post.todo.clear_date = complete_todos
            post.todo.cleared    = true
            puts post.todo.inspect
            post.todo.save!
            if post.save!
                render json: {message: "シェアが完了しました", id: post.todo}, status:200
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
