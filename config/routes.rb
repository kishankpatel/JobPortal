Rails.application.routes.draw do
  get 'candidate/index'
  resources :jobs
  get 'home/index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: "home#index"
  get '/apply_job/:id', action: :apply, controller: 'jobs'
  get '/approve/:id', action: :approve, controller: 'jobs'
  get '/unapprove/:id', action: :unapprove, controller: 'jobs'
  get '/candidates', action: :index, controller: 'candidate'
  get '/candidates/invite/:id', action: :invite, controller: 'candidate'
  post '/candidate/create', action: :create_candidate, controller: 'home'
end
