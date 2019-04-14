class AddColumnnTodos < ActiveRecord::Migration[5.2]
  def change
    add_column :todos, :clear_date, :datetime
    add_column :todos, :posted, :boolean, default: false
  end
end
