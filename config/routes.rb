Mahatma::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :emails, only: [:new, :create]

  authenticated :user do
    root 'emails#new', as: :authenticated_root
  end
  root to: redirect('/users/sign_in')

end
