Rails.application.routes.draw do
  devise_for  :members, 
              :path => '',
              :path_names => {:sign_in => 'login', :sign_out => 'logout', :sign_up => 'signup'},
              :controllers => { registrations: 'registrations' }

  
  root 'home#index'

  resources :members, only: [:edit, :update, :destroy] do
    resource :profile, only: [:edit] do
      collection do
        put 'upload_avatar'
      end
    end
  end

  get 'profile', to: 'members#edit'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
