Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  root "insta_clones#index"
  resources :sessions, only: [:new,:create,:destroy]
  resources :users, only: [:index,:new,:create,:update,:show,:destroy]
  resources :relationships, only: [:create,:destroy]
  resources :insta_clones, only: [:index]
  resources :favorites,only:[:create,:destroy]
  resources :blogs do
    collection do
      post :confirm
      get  :list
    end
    resources :comments
  end

  resources :conversations do
    resources :messages
  end

  mount LetterOpenerWeb::Engine,at:"/letter_opener" if Rails.env.development?
end
