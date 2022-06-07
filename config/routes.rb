Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users #一番上に記述
  root :to =>"homes#top"
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy] #いいね機能
    resource :comments, only: [:create, :destroy] #コメント
  end 
  
  
  resources :users, only: [:index,:show,:edit,:update] do 
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings' #名前付ルートにすることでパスの記述を簡単にする
    get 'followers' => 'relationships#followers', as: 'followers' #ビュー
  end 
  
  get 'search' => "searchs#search" #Searchesコントローラーのsearchアクションが実行されるように定義
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end 
