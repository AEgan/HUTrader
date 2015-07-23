class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :position
      t.integer :team_id
      t.integer :overall
      t.string :style

      t.timestamps null: false
    end
  end
end
