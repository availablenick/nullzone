class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :mensagem
      t.references :topico, foreign_key: true
      t.references :usuario, foreign_key: true

      t.timestamps
    end
  end
end
