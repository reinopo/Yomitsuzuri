
Rails.application.routes.draw do
  # 認証
  devise_for :users

  # リソース
  resources :users, only: [:show]
  resources :search, only: [:index]

  # 静的ページ
  get 'static/terms' => "static#terms", as: :terms
  get 'static/privacy' => "static#privacy", as: :privacy
  get 'static/contact' => "static#contact", as: :contact

  # その他カスタムルート
  get 'home/index' => 'home#index'
  get 'search/index' => 'search#index'
  get 'books/index' => 'books#index'
  get 'books/show' => 'books#show'
  get 'reading_logs/create' => 'reading_logs#create'
  get 'reading_logs/update' => 'reading_logs#update'
  get 'reading_logs/destroy' => 'reading_logs#destroy'
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
