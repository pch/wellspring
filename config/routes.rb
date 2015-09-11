Wellspring::Engine.routes.draw do
  scope "/:content_class" do
    resources :entries
  end

  root to: 'dashboard#index'
end
