class AddColumnToTodo < ActiveRecord::Migration[5.2]
  def change
    add_column :todos, :title, :string
    remove_reference :todos, :menus, foreign_key:true
  end
end
