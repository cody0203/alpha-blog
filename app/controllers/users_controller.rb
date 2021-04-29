class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def index
    @users = User.all
  end

  def show
    @articles = @user.articles
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path
    else
      @username_error = @user.errors.include?(:username)
      @email_error = @user.errors.include?(:email)
      @password_error = @user.errors.include?(:password)
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      @username_error = @user.errors.include?(:username)
      @email_error = @user.errors.include?(:email)
      @password_error = @user.errors.include?(:password)
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
