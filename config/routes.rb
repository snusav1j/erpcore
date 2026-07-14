Rails.application.routes.draw do
  devise_for :users,
             path: "",
             skip: [:registrations, :passwords, :confirmations, :unlocks],
             path_names: {
               sign_in: 'login',
               sign_out: 'logout'
             }

  root to: redirect('/clients')

  resources :table_settings, only: [:index] do
    collection do
      patch :update_positions
    end
  end

  resources :users, only: [:index, :new, :create, :edit, :update, :destroy, :show] do
    collection do
      get :new_modal
      get :edit_modal
    end
  end

  resources :products do
    collection do
      get :new_modal
      get :edit_modal
    end
    
    member do
    end
  end

  resources :companies do
    collection do
      get :new_modal
      get :edit_modal
    end
    
    member do
    end
  end

  resources :custom_fields, only: [:index, :new, :create, :destroy, :update] do
    collection do
      get :new_modal
      get :index_modal
    end
    
    member do
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

  resources :client_statuses do
    collection do
      get :new_modal
      get :edit_modal
    end
    
    member do
    end
  end

  resources :interaction_statuses do
    collection do
      get :new_modal
      get :edit_modal
    end
    
    member do
    end
  end

  resources :interaction_types do
    collection do
      get :new_modal
      get :edit_modal
    end
    
    member do
    end
  end

  resources :client_types do
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
  
  resources :user_settings do
    collection do
      post :set_sidebar_state
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