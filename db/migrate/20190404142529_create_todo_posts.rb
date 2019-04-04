class CreateTodoPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :todo_posts do |t|
      t.references :todo, foreign_key: true, index:true
      t.references :post, foreign_key: true, index:true

      t.timestamps
    end
  end
end
