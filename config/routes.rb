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

  resources :locations do
    get :add_images, on: :member
  end

end
