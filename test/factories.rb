FactoryGirl.define do

  factory :user do
    username "egan"
    email "egan@example.com"
    password "secret"
    password_confirmation "secret"
    console 2
    team_name "TheHype"
  end

  factory :team do
    city "New York"
    name "Islanders"
  end

  factory :player do
    first_name "Claude"
    last_name "Giroux"
    position "C"
    overall 90
    style "PLY"
    association :team
  end

end
