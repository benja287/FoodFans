Rails.application.routes.draw do
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
    resources :comidas, only: [:new, :create,:index, :show]
  end
resources :usuarios, only: [:index, :show]
   devise_for :users
   root 'main#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
