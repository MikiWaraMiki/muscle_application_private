class TodosController < ApplicationController
  def new
  end

  def create
    todo = current_user.todos.build(todo_params)
    if todo.save!
      render json: {data:todo}, status:200
    end
  rescue => error
      render json: {errors:todo.errors.full_messages},status:422
  end

  def show_graph
    @todos = current_user.todos
    render json: {
      #datas: @todos.gruopby_count_by_title
      datas: @todos.where(cleared: true).group('title').count   
    },status:200
#    respond_to do |format|
#      format.html
#      format.json do{
#        render json:{
#          datas: @todo.gruopby_count_by_title
#        },status:200
#      }
#     end
  end

  private
  def todo_params
    params.require(:todo).permit(:weight,:set_count,:clear_plan,:title)
  end
end
