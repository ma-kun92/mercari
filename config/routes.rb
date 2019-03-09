Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'registrations'}
  devise_scope :user  do
    post 'registration' => 'devise/registrations#create', as: :create_registration
  end

  resources :users, only: [:index] do
    collection do
      get 'register_user_address'
      post 'register_user_card'
      post 'register_user_complete'
      get 'logout'
    end
  end

  resources :items
  get 'items/:id/buy' => 'items#buy'
  root 'items#index'

end
