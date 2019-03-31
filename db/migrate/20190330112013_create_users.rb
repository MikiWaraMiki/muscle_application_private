class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, limit:30, null: false
      t.string :email, limit:100, null: false

      t.timestamps
    end
  end
end
