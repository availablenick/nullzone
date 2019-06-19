class CreateDenunciations < ActiveRecord::Migration[5.2]
  def change
    create_table :denunciations do |t|
      t.string :denunciador
      t.string :denunciado
      t.string :tipo
      t.integer :source_id

      t.timestamps
    end
  end
end
