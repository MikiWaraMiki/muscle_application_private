class CreateMenus < ActiveRecord::Migration[5.2]
  has_many :todos
  def change
    create_table :menus do |t|
      t.string :title, null: false
      t.string :muscle_point, null:false
      t.timestamps
    end
  end
end
