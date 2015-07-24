Rails.application.routes.draw do

  resources :checklist_items

  resources :checklists

  resources :tasks do
    resources :comments
  end

  mount Ckeditor::Engine => '/ckeditor'
  resources :reports do
    resources :comments
  end

  resources :roles do
    resources :comments
  end

  resources :members do
    resources :comments
  end

  resources :circles do
    resources :comments
  end

  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
  resources :users

  get '/unit_role/:type/:id' => 'roles#list' ,:as => :unit_roles
  get '/upload' => 'visitors#upload'
  post '/upload' => 'visitors#parser', :as => :parser
  get '/special-circles' => 'visitors#special_circles', :as => :special_circles
  get '/set-member' => 'users#set_member', :as => :set_member
  post '/set-member' => 'users#assign_member', :as => :assign_member
  get '/reveal' => 'visitors#reveal', :as => :reveal
end
