# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)

    # Verifica si el email está registrado
    if resource.errors[:email].present?
      flash.now[:alert] = "El correo electrónico ingresado no está registrado en nuestro sistema."
      respond_with(resource, location: new_user_password_path) # Redirige a la misma página
    else
      set_flash_message!(:notice, :send_instructions)
      respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
    end
  end
  
end
