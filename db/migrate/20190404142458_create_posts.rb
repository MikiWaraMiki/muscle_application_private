class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :users, foreign_key: true
      t.references :todos, foreign_key: true
      t.string :comment, :default => "タスクを完了しました!"
      t.timestamps
    end
  end
end
