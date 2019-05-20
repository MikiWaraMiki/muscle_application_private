module Api
    class Api::TodoController < ApplicationController
        before_action :authenticate_api_user!
        protect_from_forgery with: :null_session
        
        def create
            @user = current_api_user
            @todo = @user.todos.build(create_todo_params)
            if @todo.save
                render json: {data:@todo}, status: 200
            else
                render json:{errors: @todo.errors.full_messages}, status:422
            end
        end

        private
        def create_todo_params
            params.require(:todo).permit(:title,:set_count,:weight,:clear_plan)
        end
    end
end
