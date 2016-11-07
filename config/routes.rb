Rails.application.routes.draw do
  devise_for  :members, 
              :path => '',
              :path_names => {:sign_in => 'login', :sign_out => 'logout', :sign_up => 'signup'},
              :controllers => { registrations: 'registrations' }

  
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

end
