require './test/contexts'
include Contexts

Given /^a logged-in user$/ do
  visit login_path
  fill_in "username", with: "egan"
  fill_in "password", with: "secret"
  click_button("Log In")
end

Given /^a logged-in xbox user$/ do
  visit login_path
  fill_in "username", with: "ryan"
  fill_in "password", with: "secret"
  click_button("Log In")
end

Given /^an initial setup$/ do
  create_users
end

Given /^a setup of teams and players$/ do
  create_users
  create_teams
  create_players
end

Given /^a setup of trades$/ do
  create_users
  create_teams
  create_players
  create_trades
end

Given /^no setup yet$/ do
  # assumes initial setup already run as background
  destroy_users
end
