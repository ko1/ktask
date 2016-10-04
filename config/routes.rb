Rails.application.routes.draw do
  root to: 'statuses#index'

  resources :tasks do
    member do
      post 'register'
      get 'register'
    end
  end

  resources :results do
    member do
      get 'complete'
      post 'complete'
    end
    collection do
      get 'deq'
      post 'deq'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
