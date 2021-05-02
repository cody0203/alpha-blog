class SessionsController < ApplicationController
  def new; end

  def create
    email_param = params[:session][:email]
    password_param = params[:session][:password]
    @user = User.find_by(email: email_param)
    @email = email_param

    if email_param.blank?
      @email_error = 'Please enter your email!'
    elsif !@user && email_param
      @email_error = 'Wrong email, please try again.'
    end

    if password_param.blank?
      @password_error = 'Please enter your password!'
    elsif @user
      if @user.authenticate(password_param)
        session[:user_id] = @user.id
        redirect_to @user and return
      end
      @password_error = 'Wrong password, please try again!'
    end
    render :new
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
