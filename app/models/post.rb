class Post < ApplicationRecord
    belongs_to :todo, foreign_key: "todos_id"
    belongs_to :user, optional: true, foreign_key: 'users_id'

    
end
