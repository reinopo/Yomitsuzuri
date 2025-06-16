
Rails.application.routes.draw do
  # 認証
  devise_for :users

  # リソース
  resources :users, only: [:show]
  resources :search, only: [:index]
  resources :reading_logs, only: [:create, :update, :destroy]
  resource :mypage, only: [:show] do
    get :home  # /mypage/home
    get :favorites, path: 'favorite_authors'  # /mypage/favorite_authors
    get :citations  # /mypage/citations
  end
  resources :books, only: [:index, :show]
  resources :reading_logs, only: [] do
    resources :citations, only: [:create]
  end


  # 静的ページ
  get 'static/terms' => "static#terms", as: :terms
  get 'static/privacy' => "static#privacy", as: :privacy
  get 'static/contact' => "static#contact", as: :contact

  # その他カスタムルート
  get 'home/index' => 'home#index'
  get 'search/index' => 'search#index'
  get 'favorite_authors/create' => 'favorite_authors#create'
  get 'favorite_authors/destroy' => 'favorite_authors#destroy'

  # ルートパス
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  # ヘルスチェック
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
