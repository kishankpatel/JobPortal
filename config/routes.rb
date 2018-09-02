Rails.application.routes.draw do
  root to: "home#index"
  
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :jobs do
    member do
      get :apply, :approve, :unapprove
    end
  end

  resources :candidates, only: [:index, :create] do
    member do
      get :invite
    end
    collection do
      post :send_invitation
    end
  end

  resources :invitations, only: [] do
    member do
      get :accept, :reject
    end
    collection do
      patch :reject_job
    end
  end
end
