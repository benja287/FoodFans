class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.date :fecha
      t.integer :puntaje
      t.text :opinion
      t.references :comida, null: false, foreign_key: true
      t.references :lugar, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true  # Cambiado a :user

      t.timestamps
    end
  end
end
