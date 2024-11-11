Rails.application.routes.draw do
  get 'opinions/index'
  get 'opinions/show'
  get 'opinions/new'
  get 'opinions/create'

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
     resources :opinions, only: [:new, :create, :index, :show]
     resources :comidas, only: [:index, :show, :new, :create, :edit, :destroy, :update] do
       resources :opinions, only: [:new, :create, :index, :show]
     end
   end

   # Ruta para ver todas las opiniones
   resources :opinions, only: [:index, :show]

  resources :usuarios, only: [:index, :show]

  devise_for :users

  root 'main#home'
end
