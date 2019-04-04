class CreateToDoMuscles < ActiveRecord::Migration[5.2]
  def change
    belongs_to :users
    belogns_to :menus
    create_table :to_do_muscles do |t|
      t.integer :wight, default:1 , null: false
      t.integer :set_count, default:1, null: false
      t.datetime :clear_plan
      t.boolean :cleared
      

      t.timestamps
    end
  end
end
