Rails.application.routes.draw do
  resources :roles

  resources :members

  resources :circles

  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
  resources :users

  get '/unit_role/:type/:id' => 'roles#list' ,:as => :unit_roles
end
