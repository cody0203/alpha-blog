class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update]
  before_action :require_admin, except: %i[index show]

  def index
    @categories = pagination(Category, 5)
  end

  def show
    @articles = pagination(@category.articles, 5)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to @category
    else
      @name_error = @category.errors.include?(:name)
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to @category
    else
      @name_error = @category.errors.include?(:name)
      render :edit
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    redirect_to categories_path unless logged_in? && current_user.admin?
  end
end
