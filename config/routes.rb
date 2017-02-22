Rails.application.routes.draw do


  resources :image_uploads
  root 'pages#home'

  devise_for :users,
             :path => '',
             :path_name => {:sign_in => 'login', :sign_out => 'logout', :edit => 'profile'},
             :controllers => {:omniauth_callbacks => 'omniauth_callbacks',
                              :registrations => 'registrations'}

  resources :users, only: [:show]

  resources :experiences, only: [:new, :create, :edit, :update, :show, :index] do
    resources :build, only: [:show, :update], controller: 'experience/build'
  end

  resources :experiences do
    resources :reservations, only: [:create]
  end

  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end

  resources :users do
    resources :reviews, only: [:create, :destroy]
  end

  get '/your_outings' => 'reservations#your_outings'
  get '/your_reservations' => 'reservations#your_reservations'




end
