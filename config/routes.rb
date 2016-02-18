Wellspring::Engine.routes.draw do
  post 'preview', to: 'previews#show', as: :preview

  resources :images

  post 'images/create', as: :image_upload

  scope "/:content_class" do
    resources :entries
  end

  root to: 'dashboard#index'
end
