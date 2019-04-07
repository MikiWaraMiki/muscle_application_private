class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.references :todo_post, foreign_key: true
      t.string :commnet
      t.timestamps
    end
  end
end
