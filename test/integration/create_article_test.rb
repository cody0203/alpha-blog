require 'test_helper'

class CreateArticleTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "Admin123", email: "admin@gmail.com", password: "password")
    @article = Article.create(title: "New article", description: "Description for new article", user: @user)
  end

  test 'get new article form and create article' do
    sign_in_as(@user)
    get new_article_url
    assert_response :success
    assert_difference "Article.count", 1 do
      post articles_url, params: { article: { title: "Second article", description: "Description for second article",
                                              user: @user } }
      assert_response :redirect
    end

    follow_redirect!
    assert_match 'Second article', response.body
  end

  test 'reject get new article form' do
    get new_article_url
    assert_response :redirect
    follow_redirect!
    assert_match 'Sign in', response.body
  end

  test 'get new article form and reject invalid empty data' do
    sign_in_as(@user)
    get new_article_url
    assert_response :success
    assert_no_difference "Article.count" do
      post articles_url, params: { article: { title: "", description: "",
                                              user: @user } }
    end

    assert_select 'input#article_title.is-invalid'
    assert_select 'p.invalid-feedback', text: "Title can't be blank"
    assert_select 'p.invalid-feedback', text: "Title is too short (minimum is 6 characters)"

    assert_select 'textarea#article_description.is-invalid'
    assert_select 'p.invalid-feedback', text: "Description can't be blank"
    assert_select 'p.invalid-feedback', text: "Description is too short (minimum is 10 characters)"
  end

  test 'get new article form and reject invalid empty title' do
    sign_in_as(@user)
    get new_article_url
    assert_response :success
    assert_no_difference "Article.count" do
      post articles_url, params: { article: { title: "", description: "Description for second article",
                                              user: @user } }
    end

    assert_select 'input#article_title.is-invalid'
    assert_select 'p.invalid-feedback', text: "Title can't be blank"
  end

  test 'get new article form and reject invalid title too short' do
    sign_in_as(@user)
    get new_article_url
    assert_response :success
    assert_no_difference "Article.count" do
      post articles_url, params: { article: { title: "a", description: "Description for a article",
                                              user: @user } }
    end

    assert_select 'input#article_title.is-invalid'
    assert_select 'p.invalid-feedback', text: "Title is too short (minimum is 6 characters)"
  end

  test 'get new article form and reject invalid empty description' do
    sign_in_as(@user)
    get new_article_url
    assert_response :success
    assert_no_difference "Article.count" do
      post articles_url, params: { article: { title: "Second article", description: "",
                                              user: @user } }
    end

    assert_select 'textarea#article_description.is-invalid'
    assert_select 'p.invalid-feedback', text: "Description can't be blank"
    assert_select 'p.invalid-feedback', text: "Description is too short (minimum is 10 characters)"
  end

  test 'get new article form and reject invalid description too short' do
    sign_in_as(@user)
    get new_article_url
    assert_response :success
    assert_no_difference "Article.count" do
      post articles_url, params: { article: { title: "Second article", description: "a",
                                              user: @user } }
    end

    assert_select 'textarea#article_description.is-invalid'
    assert_select 'p.invalid-feedback', text: "Description is too short (minimum is 10 characters)"
  end
end