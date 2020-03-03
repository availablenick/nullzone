class CreateComplaints < ActiveRecord::Migration[5.2]
  def change
    create_table :complaints do |t|
      t.string :which_type
      t.string :complainee
      t.references :user, foreign_key: true
      t.references :complainable, polymorphic: true

      t.timestamps
    end
  end
end
