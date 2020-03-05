class CreateBans < ActiveRecord::Migration[5.2]
  def change
    create_table :bans do |t|
      t.text :reason
      t.datetime :expires_at
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
