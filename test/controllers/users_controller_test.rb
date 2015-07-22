require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  setup do
    create_users
  end

  teardown do
    destroy_users
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:user)
  end

  test "should not get new if someone is logged in" do
    session[:user_id] = @alex.id
    get :new
    assert_already_logged_in
  end

  test "should get show" do
    get :show, id: @alex.id
    assert_response :success
    assert_not_nil assigns(:user)
  end

  test "should get edit if logged in as correct user" do
    session[:user_id] = @alex.id
    get :edit, id: @alex.id
    assert_response :success
    assert_not_nil assigns(:user)
  end

  test "should not get edit if not logged in" do
    get :edit, id: @alex.id
    assert_equal "You are not authorized to preform this action.", flash[:warning]
    assert_redirected_to :home
  end

  test "should not get edit if logged in with the wrong user" do
    session[:user_id] = @ryan.id
    get :edit, id: @alex.id
    assert_not_authorized
  end

  test "should post create to create a new user" do
    assert_difference("User.count") do
      post :create, user: { username: "post", team_name: "post", console: 1, password: "secret", password_confirmation: "secret", email: "post@example.com" }
    end
    assert_redirected_to user_path(assigns(:user))
    assert_equal "Welcome to HUTrader, post!", flash[:notice]
  end

  test "should not post create successfully if already logged in" do
    session[:user_id] = @alex.id
    assert_no_difference("User.count") do
      post :create, user: { username: "post", team_name: "post", console: 1, password: "secret", password_confirmation: "secret", email: "post@example.com" }
    end
    assert_already_logged_in
  end

  test "should put update to edit an existing user if already logged in" do
    session[:user_id] = @alex.id
    put :update, id: @alex.id, user: { username: "aegan", team_name: "TheHype", console: 2, password: "secret", password_confirmation: "secret", email: "egan@example.com" }
    assert_equal "Successfully updated your account.", flash[:notice]
    assert_redirected_to user_path(assigns(:user))
  end

  test "should patch update to edit an existing user if logged in as correct user" do
    session[:user_id] = @alex.id
    patch :update, id: @alex.id, user: { username: "aegan", team_name: "TheHype", console: 2, password: "secret", password_confirmation: "secret", email: "egan@example.com" }
    assert_equal "Successfully updated your account.", flash[:notice]
    assert_redirected_to user_path(assigns(:user))
  end

  test "should not patch update to edit existing user if not logged in" do
    patch :update, id: @alex.id, user: { username: "aegan", team_name: "TheHype", console: 2, password: "secret", password_confirmation: "secret", email: "egan@example.com" }
    assert_not_authorized
  end

  test "should not patch update to edit existing user not logged in as correct user" do
    session[:user_id] = @ryan.id
    patch :update, id: @alex.id, user: { username: "aegan", team_name: "TheHype", console: 2, password: "secret", password_confirmation: "secret", email: "egan@example.com" }
    assert_not_authorized
  end

  test "should not create a user if a validation fails" do
    assert_no_difference("User.count") do
      # repeat username
      post :create, user: { username: "egan", team_name: "post", console: 1, password: "secret", password_confirmation: "secret", email: "post@example.com" }
    end
    assert_template :new
  end

  test "should not update successfully if validation fails" do
    session[:user_id] = @alex.id
    # non matching emails
    patch :update, id: @alex.id, user: { username: "aegan", team_name: "TheHype", console: 2, password: "secret", password_confirmation: "notsecret", email: "egan@example.com" }
    assert_template :edit
  end

  def assert_already_logged_in
    assert_equal "You are already logged in, so you cannot create an account.", flash[:warning]
    assert_redirected_to :home
  end

  def assert_not_authorized
    assert_equal "You are not authorized to preform this action.", flash[:warning]
    assert_redirected_to :home
  end

end
