class CreateOpinions < ActiveRecord::Migration[7.0]
  def change
    create_table :opinions do |t|
      t.date :fecha
      t.integer :puntaje
      t.text :comentario
      t.references :user, null: false, foreign_key: true
      t.references :lugar, null: true, foreign_key: true
      t.references :comida, null: true, foreign_key: true

      t.timestamps
    end
  end
end
