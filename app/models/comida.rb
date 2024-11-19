class Comida < ApplicationRecord
  belongs_to :lugar
  has_one_attached :photo
  has_many :opinions, dependent: :destroy
  validates :nombre, :precio, :sabor, presence: true
  validates :precio, numericality: { greater_than: 0, message: "debe ser un número positivo" }
  validate :validate_unique_food_name
  validate :validate_tipo_comida_count

  private

  def validate_unique_food_name
    # Busca si existe una comida con el mismo nombre en el mismo lugar
    existing_comida = lugar.comidas.find_by(nombre: nombre)

    if existing_comida.present? && (new_record? || existing_comida.id != id)
      errors.add(:nombre, "Ya existe una comida registrada con este nombre en este lugar")
    end
  end

  def validate_tipo_comida_count
    # Asegúrate de que tipo_comida es un array antes de contar
    selected_types = tipo_comida.is_a?(Array) ? tipo_comida.reject(&:blank?) : []

    if selected_types.length > 3
      errors.add(:tipo_comida, "Solo puedes seleccionar hasta 3 tipos de comida")
    elsif selected_types.empty?
      errors.add(:tipo_comida, "Debes seleccionar al menos un tipo de comida")
    end
  end

end
