class RemoveMusclePointFromMenus < ActiveRecord::Migration[5.2]
  def change
    remove_column :menus, :muscle_point, :string
  end
end
