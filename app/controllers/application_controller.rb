class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  def pagination(data)
    data.paginate(page: params[:page], per_page: 10)
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end
end
