require './test/contexts'
include Contexts

Given /^a logged-in user$/ do
  visit login_path
  fill_in "username", with: "egan"
  fill_in "password", with: "secret"
  click_button("Log In")
end

Given /^an initial setup$/ do
  # context used for phase 3 only
  create_users
end

Given /^no setup yet$/ do
  # assumes initial setup already run as background
  destroy_users
end
