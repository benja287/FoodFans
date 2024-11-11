Rails.application.routes.draw do
  get 'reviews/index'
  get 'reviews/new'
  get 'reviews/show'

  devise_for :admins, controllers: {
    registrations: 'admin/registrations'
  }

  resources :admin, only: [:index] do
    # Otras rutas específicas para administrar usuarios
    get 'new_user_registration', on: :collection
    post 'create_user', on: :collection
  end

  # Ruta para cargar información
  get 'cargar_informacion', to: 'main#cargar_informacion'  # Cargar Información en el controlador Main

  resources :lugares do
    # Reseñas asociadas a un lugar
    resources :reviews, only: [:new, :create, :index]

    resources :comidas, only: [:index, :show, :new, :create, :edit, :destroy, :update] do
      # Reseñas asociadas a una comida de un lugar específico
      resources :reviews, only: [:new, :create, :index]
    end
  end

  resources :usuarios, only: [:index, :show]

  devise_for :users

  root 'main#home'
end
