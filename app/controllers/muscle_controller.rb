class MuscleController < ApplicationController

    def index
        @all_posts = Post.all.limit(2).order('created_at DESC')
        @user      = User.new
    end

    
end
