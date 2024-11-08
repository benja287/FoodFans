class CreateComidas < ActiveRecord::Migration[7.0]
  def change
    create_table :comidas do |t|
      t.string :nombre
      t.string :sabor
      t.decimal :precio
      t.date :fecha_de_registro
      t.string :tipo_comida
      t.references :lugar, null: false, foreign_key: true

      t.timestamps
    end
  end
end
