Rails.application.routes.draw do
   root 'rides#index'
   get  'rides/stats', to: 'rides#stats', as: :rides_stats
   resources :rides, except: [:edit,:update,:destroy]
end
