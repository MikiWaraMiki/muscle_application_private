module Api
    module Auth
        class SessionsController < DeviseTokenAuth::SessionsController
            private
                def sign_in_params
                    params.permit(:email, :password)
                end
        end
    end
end