class TodosController < ApplicationController
  def new
  end

  def create
    todo = current_user.todos.build(todo_params)
    if todo.save!
      render json: {data:todo}, status:200
    end
  rescue => error
      render json: {message: error}, status:500
  end

  private
  def todo_params
    params.require(:todo).permit(:weight,:set_count,:clear_plan,:title)
  end
end
