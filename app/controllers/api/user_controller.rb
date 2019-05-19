module Api
    class Api::UserController < ApplicationController
        protect_from_forgery with: :null_session
        before_action :authenticate_user!

        def index
            #未完了Todo一覧を取得
            @todo_not_complete = current_user.todos.where(cleared: false);
            render json: @todo_not_complete
        end
    end
end