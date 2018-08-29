Rails.application.routes.draw do
  get 'candidate/index'
  resources :jobs
  get 'home/index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: "home#index"
  get '/apply_job/:id', action: :apply, controller: 'jobs'
  get '/approve/:id', action: :approve, controller: 'jobs'
  get '/unapprove/:id', action: :unapprove, controller: 'jobs'
  post '/candidate/create', action: :create_candidate, controller: 'home'
  get '/candidates', action: :index, controller: 'candidate'
  get '/candidates/invite/:id', action: :invite, controller: 'candidate'
  post '/candidates/send_invitation', action: :send_invitation, controller: 'candidate'
  get '/invitation/accept/:id', action: :accept_invitation, controller: 'home'
  get '/invitation/reject/:id', action: :reject_invitation, controller: 'home'
  patch '/invitation/reject_job', action: :reject_job, controller: 'home'
end
