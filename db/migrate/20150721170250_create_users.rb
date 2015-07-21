class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :email
      t.integer :console
      t.string :team_name
      t.decimal :reputation

      t.timestamps null: false
    end
  end
end
