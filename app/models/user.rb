class User < ApplicationRecord
  # Incluye solo los módulos necesarios de Devise
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable

  # Roles de usuario
  enum role: { user: 0, admin: 1 }

  # Callback para asignar el rol por defecto
  after_initialize :set_default_role, if: :new_record?

  # Relaciones
  has_many :opinions, dependent: :destroy
  has_many :lugares

  # Validaciones manuales
validates :email, presence: true, uniqueness: true, format: {
  with: URI::MailTo::EMAIL_REGEXP,
  message: "Debe ser un correo electrónico válido."
  }
 validates :password, presence: true, length: {
   minimum: 8,
   message: "La contraseña debe contener al menos 8 caracteres."
  }
 validate :password_confirmation_matches
validate :authenticate_user, on: :login # Agregamos 'on: :login' aquí
  private

  #Método para asignar el rol predeterminado
  def set_default_role
    self.role ||= :user
  end
  #Validación personalizada para confirmar que las contraseñas coinciden
  def password_confirmation_matches
    #Solo validar si las contraseñas están presentes
  if password.present? && password_confirmation.present?
   unless password == password_confirmation
       errors.add(:password_confirmation, "La confirmación de contraseña no coincide con la contraseña.")
    end
  end
  end
  # Método para validar email existente y contraseña correcta
  def authenticate_user
    return unless validation_context == :login # Solo ejecutar en contexto de login

    existing_user = User.find_by(email: email)
    if existing_user.nil?
      errors.add(:email, "El email ingresado no se encuentra registrado")
    elsif existing_user.present? && !existing_user.valid_password?(password)
      errors.add(:password, "La contraseña no es válida. Intente nuevamente")
    end
  end
end
