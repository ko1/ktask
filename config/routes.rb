Rails.application.routes.draw do
  resources :workers
  root to: 'statuses#index'
  get 'tasks/dequeue', to: 'tasks#dequeue'
  resources :tasks
  resources :results
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
