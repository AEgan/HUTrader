class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer :trade_id
      t.integer :user_id
      t.integer :coins, default: 0

      t.timestamps null: false
    end
  end
end
