class CreateResposta < ActiveRecord::Migration[5.2]
  def change
    create_table :resposta do |t|
      t.text :mensagem
      t.string :topico_id
      t.integer :
      t.integer :usuario_id

      t.timestamps
    end
  end
end
