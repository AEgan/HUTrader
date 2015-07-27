class AddIndexesToOfferForeignKeys < ActiveRecord::Migration
  def change
    add_index :offers, [:trade_id, :user_id]
    add_index :offers, [:user_id, :trade_id]
  end
end
