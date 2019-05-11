class CreateRespostas < ActiveRecord::Migration[5.2]
  def change
    create_table :respostas do |t|
      t.text :mensagem
      t.integer :topico_id
      t.integer :usuario_id

      t.timestamps
    end
  end
end
