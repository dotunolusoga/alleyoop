Rails.application.routes.draw do


  namespace :experience do
  get 'build_controller/show'
  end

  namespace :experience do
  get 'build_controller/update'
  end

  devise_for :users,
             :path => '',
             :path_name => {:sign_in => 'login', :sign_out => 'logout', :edit => 'profile'},
             :controllers => {:omniauth_callbacks => 'omniauth_callbacks',
                              :registrations => 'registrations'}

  resources :users, only: [:show]

  resources :experiences, only: [:new, :create, :show, :index] do
    resources :build, only: [:show, :update], controller: 'experience/build'
  end


end
