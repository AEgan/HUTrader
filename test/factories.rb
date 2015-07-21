FactoryGirl.define do

  factory :user do
    username "egan"
    email "egan@example.com"
    password "secret"
    password_confirmation "secret"
    console 2
    team_name "TheHype"
  end

end
