class CreateTopicos < ActiveRecord::Migration[5.2]
  def change
    create_table :topicos do |t|
      t.string :titulo
      t.text :mensagem
      t.references :usuario, foreign_key: true

      t.timestamps
    end
  end
end
