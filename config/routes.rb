Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  resources :reports

  resources :roles

  resources :members

  resources :circles

  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
  resources :users

  get '/unit_role/:type/:id' => 'roles#list' ,:as => :unit_roles
  get '/upload' => 'visitors#upload'
  post '/upload' => 'visitors#parser', :as => :parser
  get '/special-circles' => 'visitors#special_circles', :as => :special_circles
end
