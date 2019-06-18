class CreateDenunciations < ActiveRecord::Migration[5.2]
  def change
    create_table :denunciations do |t|
      t.string :denunciador
      t.string :denunciado
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
