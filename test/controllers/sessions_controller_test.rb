require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  setup do
    create_users
  end

  teardown do
    destroy_users
  end

  should "access the login page" do
    get :new
    assert_response :success
  end

  should "successfully login with valid credentials" do
    assert_nil session[:user_id]
    post :create, username: "egan", password: "secret"
    assert_redirected_to @alex
    assert_equal @alex.id, session[:user_id]
    assert_equal "Successfully signed in.", flash[:notice]
  end

  should "not successfully login when the username and password do not match" do
    assert_nil session[:user_id]
    post :create, username: "egan", password: "wrongpass"
    assert_template :new
    assert_equal "Invalid username or password.", flash[:error]
    assert_nil session[:user_id]
  end

  should "be able to logout" do
    session[:user_id] = @alex.id
    get :destroy
    assert_redirected_to :home
    assert_equal "Goodbye", flash[:notice], session.to_yaml
    assert_nil session[:user_id]
  end

  should "redirect to the user's show page and get a message if you try to log in when already logged in" do
    session[:user_id] = @alex.id
    get :new
    assert_redirected_to @alex
    assert_equal "Already logged in.", flash[:notice]
  end

  should "give a message if a user tries to log out but they were never logged in" do
    session[:user_id] = nil
    get :destroy
    assert_redirected_to :home
    assert_equal "You were not logged in.", flash[:notice]
  end

  should "redirect to their account with a message if they submit a login request while already logged in" do
    session[:user_id] = @alex.id
    post :create, username: 'nothing', password: 'here'
    assert_redirected_to @alex
    assert_equal "Already logged in.", flash[:notice]
    assert_equal @alex.id, session[:user_id]
  end
end
