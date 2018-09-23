Rails.application.routes.draw do

  
  root 'homepage#index'

  devise_for :users, controllers: { registrations: 'registrations' }
  devise_for :admins

  resources :users
  resources :articles, only: [:index, :show]

  get '404', to: 'errors#page_not_found'
  get '500', to: 'errors#internal_server_error'

  get 'contact', to: 'contact_forms#show'
  post 'contact', to: 'contact_forms#send_contact_form'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_for :users

      post 'users/sign_in', to: 'sessions#create'
      post 'users/sign_out', to: 'sessions#destroy'
      put 'users/change_password', to: 'users#update_password'
      put 'users/update', to: 'users#update'
      put 'users/update_history', to: 'users#update_history'
      post 'diseases', to: 'diseases#index'
      post 'contact_form', to: 'contact_forms#send_contact_form'
      post 'users/set_image', to: 'users#set_image'
    end
  end

  namespace :admin do
    root 'homepage#index'
    
    resources :users, :articles, :diseases
  end

end
