Wellspring::Engine.routes.draw do
  post 'preview', to: 'previews#show', as: :preview

  resources :images

  post 'images/create', as: :image_upload

  scope "/:content_class" do
    resources :entries
  end

  get 'sign-in',  to: 'sessions#new', as: 'signin'
  get 'sign-out', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:new, :create, :destroy]

  root to: 'dashboard#index'
end
