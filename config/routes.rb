Rails.application.routes.draw do
  get 'profiles/new'

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'attempts/new'

  get 'categorys/new'

  get 'headshot_demo/index'

  post "headshot/capture" => 'headshot#capture', :as => :headshot_capture
  get 'miscs/new'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'sheets/new'

  get 'score/new'

  get 'ques/new'

  get 'exams/new'

  get 'reports/new'

  get 'sessions/new'

  get 'users/new'

  root 'static_pages#home'

  get 'help' => 'static_pages#help'
  get 'about'=>'static_pages#about'
  get 'contact' => 'problems#new'
  get 'faq' => 'static_pages#faq'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'gettest' => 'users#gettest'
  get 'users/finish'
  get 'refresh_diff' => 'users#refresh_diff'
  get 'update_count' => 'users#update_count'
  get 'just_fake' => 'ques#just_fake'
  get 'reset' => 'users#reset'
  get 'users/ready'
  get 'ques/ready'
  get 'ques/nextpart'
  get 'ques/gofinish'
  get 'ques/nextset'
  resources :users
  resources :ques
  resources :sheets
  resources :miscs
  resources :problems
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
