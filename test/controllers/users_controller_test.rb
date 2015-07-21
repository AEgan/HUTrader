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

  test "should get show" do
    get :show, id: @alex.id
    assert_response :success
    assert_not_nil assigns(:user)
  end

  test "should get edit" do
    get :edit, id: @alex.id
    assert_response :success
    assert_not_nil assigns(:user)
  end

  test "should post create to create a new user" do
    assert_difference("User.count") do
      post :create, user: { username: "post", team_name: "post", console: 1, password: "secret", password_confirmation: "secret", email: "post@example.com" }
    end
    assert_redirected_to user_path(assigns(:user))
    assert_equal "Welcome to HUTrader, post!", flash[:notice]
  end

  test "should put update to edit an existing user" do
    put :update, id: @alex.id, user: { username: "aegan", team_name: "TheHype", console: 2, password: "secret", password_confirmation: "secret", email: "egan@example.com" }
    assert_equal "Successfully updated your account.", flash[:notice]
    assert_redirected_to user_path(assigns(:user))
  end

  test "should patch update to edit an existing user" do
    patch :update, id: @alex.id, user: { username: "aegan", team_name: "TheHype", console: 2, password: "secret", password_confirmation: "secret", email: "egan@example.com" }
    assert_equal "Successfully updated your account.", flash[:notice]
    assert_redirected_to user_path(assigns(:user))
  end

  test "should not create a user if a validation fails" do
    assert_no_difference("User.count") do
      # repeat username
      post :create, user: { username: "egan", team_name: "post", console: 1, password: "secret", password_confirmation: "secret", email: "post@example.com" }
    end
    assert_template :new
  end

  test "should not update successfully if validation fails" do
    # non matching emails
    patch :update, id: @alex.id, user: { username: "aegan", team_name: "TheHype", console: 2, password: "secret", password_confirmation: "notsecret", email: "egan@example.com" }
    assert_template :edit
  end

end
