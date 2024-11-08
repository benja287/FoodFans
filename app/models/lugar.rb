class Lugar < ApplicationRecord
  has_many :comidas, dependent: :destroy
  validates :nombre, :direccion, :tipo, :puntaje, :descripcion, :fecha_de_registro, presence: true
  validates :nombre, uniqueness: { scope: :direccion, message: "ya está registrado en esta dirección" }
  validates :puntaje, inclusion: { in: 1..5, message: "debe estar entre 1 y 5 estrellas" }
end
