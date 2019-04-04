class ToDoMuscle < ApplicationRecord
  belongs_to :user
  has_many :todo_posts
  has_many :posts, through: :todo_posts
  def def new
    @todo = Todo.new
    @menu = Menu.order("menu_id").group("menu_title")
  end
  
end
