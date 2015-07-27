class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.integer :user_id
      t.integer :partner_id
      t.integer :player_id
      t.integer :user_rating
      t.integer :partner_rating
      t.string :status, default: "Open"

      t.timestamps null: false
    end
  end
end
