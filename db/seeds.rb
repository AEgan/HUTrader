# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
require 'factory_girl_rails'

# create users
# first, create Alex so I know I exist
alex = FactoryGirl.create(:user)
# then, create 49 others
49.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  username = (first_name[0] + last_name).downcase
  email = "#{username}@example.com"
  console = rand(2) + 1
  u = FactoryGirl.build(:user, username: username, team_name: username, email: email, console: console)
  u.save
end

# now create the teams
require 'csv'

# create the teams from the teams csv file
CSV.foreach(Rails.root + "doc/teams.csv") do |team_row|
  team = FactoryGirl.create(:team, city: team_row[0], name: team_row[1])

  # find the roster csv file and create all of the players
  roster_file_name = "doc/teams/#{team.name.sub(' ', '_').downcase}.csv"
  CSV.foreach(Rails.root + roster_file_name) do |player_row|
    FactoryGirl.create(:player, team: team,
      first_name: player_row[0],
      last_name: player_row[1],
      overall: player_row[2],
      position: player_row[3],
      style: player_row[4])
  end
end

# create open trades.. lets do 50
player_count = Player.count
first_player_id = Player.first.id
user_count = User.count
first_user_id = User.first.id
50.times do
  player = Player.find(rand(player_count) + first_player_id)
  user = User.find(rand(user_count) + first_user_id)
  FactoryGirl.create(:trade, user: user, player: player, partner: nil)
end

xbox_users = User.for_xbox
playstation_users = User.for_playstation

Trade.limit(20).includes(:user).each do |trade|
  (rand(4) + 1).times do |time|
    if trade.user.xbox_user?
      user = xbox_users[rand(xbox_users.length)]
    else
      user = playstation_users[rand(playstation_users.length)]
    end
    offer = FactoryGirl.build(:offer, trade: trade, user: user, coins: 1000 * time)
    if offer.save
      (rand(4) + 1).times do
        FactoryGirl.create(:offer_player, offer: offer, player: Player.find(rand(player_count) + first_player_id))
      end
    end
  end
  offers = trade.offers
  unless offers.empty?
    trade.partner_id = offers.last.user_id
    trade.status = rand(2) == 0 ? Trade::STATUSES['partnered'] : Trade::STATUSES['complete']
    trade.save
  end
end

Offer.all.includes(:trade, :user).each do |o|
  FactoryGirl.create(:comment, user: o.trade.user, offer: o)
  FactoryGirl.create(:comment, user: o.user, offer: o)
end
