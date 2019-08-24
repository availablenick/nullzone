class CreatePostRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :post_ratings do |t|
      t.integer :value
      t.references :post, foreign_key: true
      t.references :usuario, foreign_key: true

      t.timestamps
    end
  end
end
