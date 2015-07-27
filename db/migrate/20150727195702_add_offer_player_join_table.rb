class AddOfferPlayerJoinTable < ActiveRecord::Migration
  def change
    create_join_table :offers, :players do |t|
      t.index [:offer_id, :player_id]
      t.index [:player_id, :offer_id]
    end
  end
end
