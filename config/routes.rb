Rails.application.routes.draw do


  root 'pages#home'

  devise_for :users,
             :path => '',
             :path_name => {:sign_in => 'login', :sign_out => 'logout', :edit => 'profile'},
             :controllers => {:omniauth_callbacks => 'omniauth_callbacks',
                              :registrations => 'registrations'}

  resources :users, only: [:show]

  resources :experiences, only: [:new, :create, :show, :index] do
    resources :build, only: [:show, :update], controller: 'experience/build'

  end

  # resources :photos


end
