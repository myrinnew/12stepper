TwelveStepper::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  scope "(:locale)", locale: /en|es|fr/ do

    get '/profile/edit', to: 'users#edit', as: "edit_profile"
    get '/profile/:username', to: 'users#show', as: :user_show
    resources :users, only: [:index, :new, :create, :update]

    resources :entries

    resources :worksheet_entries
    get '/login' => "sessions#new", as: "login"

    delete '/sessions', to: 'sessions#destroy'
    resources :sessions, only: [:new, :create, :destroy]

    get '/meetings/search' => "meetings#search_meetings", as: "search_meetings"
    resources :meetings, only: [:index, :search_meetings]

    namespace :big_book do
      get '/', to: 'chapters#index'
    end

    resources :friendships, only: [:index, :create]
    post '/friendships/accept/:id', to: 'friendships#update', as: :accept_friendship
    delete '/friendships/reject/:id', to: 'friendships#destroy', as: :reject_friendship
    delete '/friendships/remove/:id', to: 'friendships#destroy', as: :remove_friendship

    namespace :friends do
      resources :search, only: [:new, :create, :index]
    end

    namespace :api do
      namespace :v1 do

        namespace :entries do
          get '/search/:query', to: 'search#show'
        end

        namespace :big_book do
          resources :chapters
          get '/search/:query', to: 'search#show'
        end

      end
    end
  end

  get "/pages/*id" => 'pages#show', as: :page, format: false

  get '/:locale', to: 'entries#index'
  root 'entries#index'
end
