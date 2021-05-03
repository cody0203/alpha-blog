class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show]

  def index
    @categories = pagination(Category, 5)
  end

  def show; end

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

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
