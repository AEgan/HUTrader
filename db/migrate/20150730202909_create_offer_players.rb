class CreateOfferPlayers < ActiveRecord::Migration
  def change
    create_table :offer_players do |t|
      t.integer :offer_id
      t.integer :player_id

      t.timestamps null: false
    end
  end
end
