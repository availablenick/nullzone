class CreateComplaints < ActiveRecord::Migration[5.2]
  def change
    create_table :complaints do |t|
      t.string :type
      t.string :complainee
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
      t.references :topic, foreign_key: true

      t.timestamps
    end
  end
end
