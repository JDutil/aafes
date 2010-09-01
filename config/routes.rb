Aafes::Application.routes.draw do
  resources :transactions

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get :recent, :on => :collection
  #     end
  #   end

  resources :users
  resources :user_sessions

  resources :clients do
    resources :transactions do
      resources :approvals
      resources :settlements
      resources :credits
    end
  end
  
  match "/logout", :to => "user_sessions#destroy"
  match "/login", :to => "user_sessions#new"
  
  root :to => "pages#index"
end