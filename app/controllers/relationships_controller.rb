class RelationshipsController < ApplicationController
    def create
        respond_to do |format|
            unless current_user.following?(get_following_user)
                current_user.follow!(get_following_user)
                @post_user = get_following_user
                format.js
            else
                alert = "すでにフォローしています"
                format.js {render partial:"shared/error_messages",status: :unprocessable_entity, locals:{alert: alert}}
            end
        end
    end

    def destroy
        respond_to do |format|
            if current_user.following?(get_following_user)
                current_user.unfollow!(get_following_user)
                @post_user = get_following_user
                format.js
            else
                alert="すでにアンフォロー済みです"
                format.js {render partial:"shared/error_messages", status: :unprocessable_entity, locals:{alert:alert}}
            end
        end
    end

    private
    def get_following_user
        User.find(params[:relationship][:following_id])
    end
end
