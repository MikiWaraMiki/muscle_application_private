class ApplicationController < ActionController::Base
    include SessionsHelper
    before_action :configure_permitted_parameters, if: :devise_controller?
    after_action :discard_flash_if_xhr
    protect_from_forgery with: :exception

    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from ActionController::RoutingError, with: :render_404
    rescue_from Exception, with: :render_500


    def after_sign_in_path_for(resource)
        user_url(resource)
    end

    def render_404(exception=nil)
        if exception
            logger.info "Rendering 404 with exception: #{exception.message}"
          end
          render template: "errors/404", status: 404, layout: 'application'
    end

    def render_500(exception=nil)
        if exception
            logger.info "Redering 500 with exception #{exception.message}"
        end
        render template "errors/500", status:500, layout:'application'
    end
    protected
    def configure_permitted_parameters
        added_attrs = [ :email, :user_name, :password, :password_confirmation ]
        devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
        devise_parameter_sanitizer.permit :account_update, keys: added_attrs
        devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    end

    def discard_flash_if_xhr
        flash.discard if request.xhr?
    end

    

end
