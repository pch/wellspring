Wellspring::Engine.routes.draw do
  resources :images

  post 'images/create', as: :image_upload

  scope "/:content_class" do
    resources :entries do
      post :preview, on: :member, as: :preview
    end
  end

  get 'sign-in',  to: 'sessions#new', as: 'signin'
  get 'sign-out', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:new, :create, :destroy]

  root to: 'dashboard#index'
end
