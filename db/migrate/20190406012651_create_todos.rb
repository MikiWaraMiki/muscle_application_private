class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos do |t|
      t.references :users, foreign_key: true
      t.references :menus, foreign_key: true
      t.integer :weight, default:1 , null: false
      t.integer :set_count, default:1, null: false
      t.datetime :clear_plan
      t.boolean :cleared
      t.timestamps
    end
  end
end
