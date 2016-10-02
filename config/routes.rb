Rails.application.routes.draw do
  root to: 'statuses#index'
  get 'api/deq', to: 'apis#deq', as: :api_deq
  get 'api/complete/:id', to: 'apis#complete', as: :api_complete

  resource :api
  
  resources :tasks do
    member do
      post 'register'
      get 'register'
    end
  end

  resources :results
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
