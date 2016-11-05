Rails.application.routes.draw do
  devise_for  :members, 
              :path => '',
              :path_names => {:sign_in => 'login', :sign_out => 'logout', :sign_up => 'signup'},
              :controllers => { registrations: 'registrations' }

  
  root 'home#index'

  resources :members, only: [:edit, :update] do
    resource :profile, only: [:edit, :update, :destroy] do
      collection do
        put 'upload_avatar'
      end
    end
  end

  #get 'profile', to: 'profiles#edit'
  get 'profile', to: 'profiles#edit'

end
