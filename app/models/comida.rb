class Comida < ApplicationRecord
  belongs_to :lugar
  has_one_attached :photo
  has_many :opinions, dependent: :destroy
  validates :nombre, :precio, :sabor, presence: true
  validate :precio_validations

def precio_validations
  if precio.nil?
    errors.add(:precio, "no puede estar en blanco.")
  elsif !precio.is_a?(Numeric)
    errors.add(:precio, "debe ser un número.")
  elsif precio <= 0
    errors.add(:base, "El precio debe ser un valor numérico positivo mayor a cero")
  end
end
  validate :validate_unique_food_name
  validate :validate_tipo_comida

  private

  def validate_unique_food_name
    # Busca si existe una comida con el mismo nombre en el mismo lugar
    existing_comida = lugar.comidas.find_by(nombre: nombre)

    if existing_comida.present? && (new_record? || existing_comida.id != id)
      errors.add(:base, "Ya hiciste un registro de esta comida en este lugar")
    end
  end

  private

  def validate_tipo_comida
    tipos = tipo_comida.to_s.split(',').map(&:strip)
    if tipos.length > 3
      errors.add(:base, "Solo puedes seleccionar hasta tres tipos de comida")
    elsif tipos.empty?
      errors.add(:base, "Debes seleccionar al menos un tipo de comida")
    end
  end

end
