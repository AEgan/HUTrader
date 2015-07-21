require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  setup do
    create_users
  end

  teardown do
    destroy_users
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should successfully login with a post create and valid credentials" do
    assert_nil session[:user_id]
    post :create, username: "egan", password: "secret"
    assert_redirected_to @alex
    assert_equal @alex.id, session[:user_id]
    assert_equal "Successfully signed in.", flash[:notice]
  end

  test "should not successfully login when the username and password do not match" do
    assert_nil session[:user_id]
    post :create, username: "egan", password: "wrongpass"
    assert_template :new
    assert_equal "Invalid username or password.", flash[:error]
    assert_nil session[:user_id]
  end

  test "should get destroy to clear the sessions's user_id" do
    session[:user_id] = @alex.id
    get :destroy
    assert_redirected_to :home
    assert_equal "Goodbye", flash[:notice], session.to_yaml
    assert_nil session[:user_id]
  end

  test "should redirect home and get a message if you try to log in when already logged in" do
    session[:user_id] = @alex.id
    get :new
    assert_redirected_to @alex
    assert_equal "Already logged in.", flash[:notice]
  end

  test "should give a message if a user tries to log out but they were never logged in" do
    session[:user_id] = nil
    get :destroy
    assert_redirected_to :home
    assert_equal "You were not logged in.", flash[:notice]
  end

  test "should redirect to their account with a message if they try post /sessions while already logged in" do
    session[:user_id] = @alex.id
    post :create, username: 'nothing', password: 'here'
    assert_redirected_to @alex
    assert_equal "Already logged in.", flash[:notice]
    assert_equal @alex.id, session[:user_id]
  end
end
