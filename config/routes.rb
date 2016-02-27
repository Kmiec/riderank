Rails.application.routes.draw do
   root 'rides#index'
   get  'rides/stats',      to: 'rides#stats', as: :rides_stats
   get  'rides/page/:page', to: 'rides#index', as: :rides_index
   resources :rides, except: [:edit,:update,:destroy]
end
