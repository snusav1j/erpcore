Rails.application.routes.draw do
  devise_for :users,
             path: "",
             skip: [:registrations, :passwords, :confirmations, :unlocks],
             path_names: {
               sign_in: 'login',
               sign_out: 'logout'
             }

  root to: 'clients#index'

  resources :users, only: [:index, :new, :create, :edit, :update, :destroy, :show] do
    collection do
      get :new_modal
      get :edit_modal
    end
  end

  resources :orders do
    collection do
      get :new_modal
      get :edit_modal
    end
    
    member do
    end
  end
  
  resources :clients do
    collection do
      get :new_modal
      get :edit_modal
    end
    
    member do
    end
  end
  
  resources :interactions do
    collection do
      get :new_modal
      get :edit_modal
    end

    member do
    end
  end
end