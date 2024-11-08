class CreateLugars < ActiveRecord::Migration[7.0]
  def change
    create_table :lugars do |t|
      t.string :nombre
      t.string :direccion
      t.string :tipo
      t.integer :puntaje
      t.text :descripcion
      t.date :fecha_de_registro

      t.timestamps
    end
  end
end
