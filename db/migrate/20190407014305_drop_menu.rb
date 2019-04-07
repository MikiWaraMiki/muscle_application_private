class DropMenu < ActiveRecord::Migration[5.2]
  def up
    drop_table :menus
  end
  def down
    create_table :menus do |t|
      t.string :title, null: false
      t.string :muscle_point, null:false
      t.timestamps
    end
  end
end
