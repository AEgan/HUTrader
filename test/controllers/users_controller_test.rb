require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  setup do
    create_users
  end

  teardown do
    destroy_users
  end

  should "give access to the new users page if not logged in" do
    get :new
    assert_response :success
    assert_not_nil assigns(:user)
  end

  should "not see the new users page if someone is logged in" do
    session[:user_id] = @alex.id
    get :new
    assert_already_logged_in
  end

  should "see a user's profile page" do
    get :show, id: @alex.id
    assert_response :success
    assert_not_nil assigns(:user)
  end

  should "be able to see the edit page if logged in as correct user" do
    session[:user_id] = @alex.id
    get :edit, id: @alex.id
    assert_response :success
    assert_not_nil assigns(:user)
  end

  should "not get to the edit page if a user is not logged in" do
    get :edit, id: @alex.id
    assert_equal "You are not authorized to perform this action.", flash[:warning]
    assert_redirected_to :home
  end

  should "not access the edit page if logged in with the wrong user" do
    session[:user_id] = @ryan.id
    get :edit, id: @alex.id
    assert_not_authorized
  end

  should "be able to create to create a new user if not logged in" do
    assert_difference("User.count") do
      post :create, user: { username: "post", team_name: "post", console: 1, password: "secret", password_confirmation: "secret", email: "post@example.com" }
    end
    assert_redirected_to user_path(assigns(:user))
    assert_equal "Welcome to HUTrader, post!", flash[:notice]
  end

  should "not be able to create a new user successfully if already logged in" do
    session[:user_id] = @alex.id
    assert_no_difference("User.count") do
      post :create, user: { username: "post", team_name: "post", console: 1, password: "secret", password_confirmation: "secret", email: "post@example.com" }
    end
    assert_already_logged_in
  end

  should "be able to update an existing user if already logged in as the correct user" do
    session[:user_id] = @alex.id
    put :update, id: @alex.id, user: { username: "aegan", team_name: "TheHype", console: 2, password: "secret", password_confirmation: "secret", email: "egan@example.com" }
    assert_equal "Successfully updated your account.", flash[:notice]
    assert_redirected_to user_path(assigns(:user))
  end

  should "patch update to edit an existing user if logged in as correct user" do
    session[:user_id] = @alex.id
    patch :update, id: @alex.id, user: { username: "aegan", team_name: "TheHype", console: 2, password: "secret", password_confirmation: "secret", email: "egan@example.com" }
    assert_equal "Successfully updated your account.", flash[:notice]
    assert_redirected_to user_path(assigns(:user))
  end

  should "not be able to update an existing user if not logged in" do
    patch :update, id: @alex.id, user: { username: "aegan", team_name: "TheHype", console: 2, password: "secret", password_confirmation: "secret", email: "egan@example.com" }
    assert_not_authorized
  end

  should "not be able to edit existing user if not logged in as correct user" do
    session[:user_id] = @ryan.id
    patch :update, id: @alex.id, user: { username: "aegan", team_name: "TheHype", console: 2, password: "secret", password_confirmation: "secret", email: "egan@example.com" }
    assert_not_authorized
  end

  should "not create a user if the username is not unique (validation failure)" do
    assert_no_difference("User.count") do
      # repeat username
      post :create, user: { username: "egan", team_name: "post", console: 1, password: "secret", password_confirmation: "secret", email: "post@example.com" }
    end
    assert_template :new
  end

  should "not update successfully if passwords do not match (validation failure)" do
    session[:user_id] = @alex.id
    patch :update, id: @alex.id, user: { username: "aegan", team_name: "TheHype", console: 2, password: "secret", password_confirmation: "notsecret", email: "egan@example.com" }
    assert_template :edit
  end

  should "gracefully handle trying to find a record that does not exist" do
    get :show, id: "wrong"
    assert_response :missing
  end

  def assert_already_logged_in
    assert_equal "You are already logged in, so you cannot create an account.", flash[:warning]
    assert_redirected_to :home
  end

end
