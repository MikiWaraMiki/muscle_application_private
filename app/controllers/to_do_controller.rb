class ToDoController < ApplicationController
    def new
        @todo = Todo.new
    end
    
    def create
    end
end
