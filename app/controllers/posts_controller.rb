class PostsController < ApplicationController
    
    def create
        post = current_user.posts.build(timeline_params)
        post.todo.posted = true
        puts post.todo.inspect
        post.todo.save!
        if post.save!
            render json: {message: "シェアが完了しました", id: post.todos_id}, status:200
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
end
