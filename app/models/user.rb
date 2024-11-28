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





  validate :email_validations, on: [:create, :update]

  def email_validations
    if email.blank?
      errors.add(:email, "El correo electrónico no puede estar en blanco.")
    elsif User.where(email: email).where.not(id: id).exists?
      errors.add(:base, "El correo electrónico ya está registrado .")
    elsif !email.match?(URI::MailTo::EMAIL_REGEXP)
      errors.add(:email, "Debe ser un correo electrónico válido.")
    end
  end

validate :password_validations

def password_validations
  if password.blank?
    errors.add(:password, "La contraseña no puede estar en blanco.")
  elsif password.length < 8
    errors.add(:base, "La contraseña debe contener al menos 8 caracteres.")
  end
end

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
       errors.add(:base, "La clave no coincide.")
    end
  end
  end
  # Método para validar email existente y contraseña correcta
 def authenticate_user
   return unless validation_context == :login # Solo ejecutar en contexto de login

   # Buscar al usuario por correo electrónico
   existing_user = User.find_by(email: email)

   # Validar si el correo no está registrado
   if existing_user.nil?
     errors.add(:email, "El email ingresado no se encuentra registrado")
   else
     # Validar la contraseña solo si el correo existe
     unless existing_user.valid_password?(password)
       errors.add(:password, "La contraseña no es válida. Intente nuevamente")
     end
   end
 end

end
