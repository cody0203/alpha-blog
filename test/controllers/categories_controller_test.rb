require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: 'Sports')
  end

  test 'should get index' do
    get categories_url
    assert_response :success
  end

  test 'should get new' do
    get new_category_url
    assert_response :success
  end

  test 'should create category' do
    assert_difference('Category.count', 1) do
      post categories_url, params: { category: { name: 'Travel' } }
    end

    assert_redirected_to category_url(Category.last)
  end

  test 'should show category' do
    get category_url(@category)
    assert_response :success
  end
end
