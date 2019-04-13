ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  include Warden::Test::Helpers
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def is_logged_in?
    !session[:user_id].nil?
  end

  def log_in(user)
    if integration_test?
      login_as(@user, :scope=>user)
    else
      sign_in(user)
    end
  end

  def integration_test?
    defined?(post-via-direct)
  end
end
