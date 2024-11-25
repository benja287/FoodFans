class Lugar < ApplicationRecord
  has_many :comidas, dependent: :destroy
  has_many :opinions, dependent: :destroy
  belongs_to :user
  validates :nombre, :direccion, :tipo, :puntaje, :descripcion, :fecha_de_registro, presence: true

  validates :puntaje, inclusion: { in: 1..5, message: "debe estar entre 1 y 5 estrellas" }
  validate :validate_unique_location
   validate :validate_unique_address

    private

    def validate_unique_location
      # Busca si existe un lugar con el mismo nombre y dirección
      existing_lugar = Lugar.find_by(nombre: nombre, direccion: direccion)

      if existing_lugar.present? && (new_record? || existing_lugar.id != id)
        errors.add(:base, "Ya existe un lugar registrado con este nombre en esta dirección")
      end
    end
    # Validación de dirección única
 def validate_unique_address
   existing_address = Lugar.find_by(direccion: direccion)
   if existing_address.present? && (new_record? || existing_address.id != id)
     errors.add(:direccion, "Ya está registrada en otro lugar")
   end
 end

end
