Rails.application.routes.draw do
  root "insta_clones#index"
  resources :sessions, only: [:new,:create,:destroy]
  resources :users, only: [:new,:create,:update,:show,:destroy]
  resources :insta_clones, only: [:index]
  resources :favorites,only:[:create,:destroy]
  resources :blogs do
    collection do
      post :confirm
      get  :list
    end
  end
  mount LetterOpenerWeb::Engine,at:"/letter_opener" if Rails.env.development?
end
