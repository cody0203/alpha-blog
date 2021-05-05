require 'test_helper'

class SignUpTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "Cody456", email: "cody456@gmail.com", password: "password")
  end

  test 'get signup form and signup new user' do
    get signup_url
    assert_response :success
    assert_difference "User.count", 1 do
      post users_url, params: { user: { username: "Cody123", email: "cody@gmail.com", password: "password" } }
      assert_response :redirect
    end

    follow_redirect!
    assert_response :success
    assert_match "Cody123", response.body
  end

  test 'get signup form and reject invalid user submission' do
    get signup_url
    assert_response :success
    assert_no_difference "User.count" do
      post users_url, params: { user: { username: "", email: "", password: "" } }
    end
    assert_select 'input#user_username.is-invalid'
    assert_select 'p.invalid-feedback', text: "Username can't be blank"
    assert_select 'p.invalid-feedback', text: "Username is too short (minimum is 6 characters)"

    assert_select 'input#user_email.is-invalid'
    assert_select 'p.invalid-feedback', text: "Email can't be blank"
    assert_select 'p.invalid-feedback', text: "Email is invalid"

    assert_select 'input#user_password.is-invalid'
    assert_select 'p.invalid-feedback', text: "Password can't be blank"
  end

  test 'get signup form and reject invalid duplicate username user submission' do
    get signup_url
    assert_response :success
    assert_no_difference "User.count" do
      post users_url, params: { user: { username: "Cody456", email: "cody789@gmail.com", password: "password" } }
    end
    assert_select 'input#user_username.is-invalid'
    assert_select 'p.invalid-feedback', text: "Username has already been taken"
  end

  test 'get signup form and reject invalid duplicate email user submission' do
    get signup_url
    assert_response :success
    assert_no_difference "User.count" do
      post users_url, params: { user: { username: "Cody789", email: "cody456@gmail.com", password: "password" } }
    end
    assert_select 'input#user_email.is-invalid'
    assert_select 'p.invalid-feedback', text: "Email has already been taken"
  end

  test 'get signup form and reject invalid empty password user submission' do
    get signup_url
    assert_response :success
    assert_no_difference "User.count" do
      post users_url, params: { user: { username: "Cody789", email: "cody789@gmail.com", password: "" } }
    end
    assert_select 'input#user_password.is-invalid'
    assert_select 'p.invalid-feedback', text: "Password can't be blank"
  end
end