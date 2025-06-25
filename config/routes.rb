
Rails.application.routes.draw do
  # 認証
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # リソース
  resources :users, only: [:show]
  resources :search, only: [:index]
  resources :reading_logs, only: [:create, :update, :destroy]
  resource :mypage, only: [:show] do
    get :home  # /mypage/home
    get :favorites, path: 'favorite_authors'  # /mypage/favorite_authors
    get :citations  # /mypage/citations
  end
  resources :books, only: [:index, :show, :update]
  resources :reading_logs, only: [] do
    resources :citations, only: [:create, :destroy]
  end
  resources :authors, only: [:show]
  resources :favorite_authors, only: [:create, :destroy]

  # 静的ページ
  get 'static/terms' => "static#terms", as: :terms
  get 'static/privacy' => "static#privacy", as: :privacy
  get 'static/contact' => "static#contact"

  # その他カスタムルート
  get 'home/index' => 'home#index'
  get  'contact',      to: 'contacts#new', as: :contact
  post 'contact/send', to: 'contacts#create'

  # ルートパス
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  # ヘルスチェック
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  patch 'reading_logs/:id/update_status', to: 'reading_logs#update_status', as: :update_reading_status
  patch 'reading_logs/:id/update_comment', to: 'reading_logs#update_comment', as: :update_comment_reading_log

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

end
