class AddIndexToTeamId < ActiveRecord::Migration
  def change
    add_index :players, :team_id
  end
end
