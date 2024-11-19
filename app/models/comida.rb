class Comida < ApplicationRecord
  belongs_to :lugar
  has_one_attached :photo
  has_many :opinions, dependent: :destroy
  validates :nombre, :precio, :sabor, presence: true
  validates :precio, numericality: { greater_than: 0, message: "debe ser un número positivo" }
  validate :validate_unique_food_name
  validate :validate_tipo_comida

  private

  def validate_unique_food_name
    # Busca si existe una comida con el mismo nombre en el mismo lugar
    existing_comida = lugar.comidas.find_by(nombre: nombre)

    if existing_comida.present? && (new_record? || existing_comida.id != id)
      errors.add(:nombre, "Ya existe una comida registrada con este nombre en este lugar")
    end
  end

  private

  def validate_tipo_comida
    tipos = tipo_comida.to_s.split(',').map(&:strip)
    if tipos.length > 3
      errors.add(:tipo_comida, "Solo puedes seleccionar hasta 3 tipos de comida")
    elsif tipos.empty?
      errors.add(:tipo_comida, "Debes seleccionar al menos un tipo de comida")
    end
  end

end
