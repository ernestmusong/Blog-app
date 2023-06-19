class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    # set the @current_user instance variable to the first user in the database, if it has not already been set.
    @current_user ||= User.first
  end
end
