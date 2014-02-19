TwelveStepper::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  scope "(:locale)", locale: /en|es|fr/ do
    resources :users
    resources :entries
    resources :sessions
    delete '/sessions', to: 'sessions#destroy'

    namespace :big_book do
      get '/', to: 'chapters#index'
      resources :chapters
    end

    namespace :api do
      namespace :v1 do
        namespace :big_book do
          resources :chapters
          get '/search/:query', to: 'search#show'
        end
      end
    end
  end

  get '/:locale', to: 'entries#index'
  root 'entries#index'
end
