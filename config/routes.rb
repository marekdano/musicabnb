Rails.application.routes.draw do

  get 'reservations/new'

  devise_for  :members, 
              :path => '',
              :path_names => {:sign_in => 'login', :sign_out => 'logout', :sign_up => 'signup'},
              :controllers => { :registrations => 'registrations', 
                                :omniauth_callbacks => "omniauth_callbacks" }

  
  root 'home#index'

  resources :members, only: [:edit, :update] do
    resource :profile, only: [:edit, :update, :destroy] do
      collection do
        patch 'upload_avatar'
      end
    end
  end

  resource :member, only: [:edit] do
    collection do
      patch 'update_password'
    end
  end

  get 'profile', to: 'profiles#edit'
  get 'member_locations', to: 'members#member_locations'

  resources :locations do
    member do
      get :add_images
      get :calendar
      get :add_available_dates
    end
  end

  resources :reservations, only: [:new, :create, :index] do
    get :confirmation, on: :member
  end

end
