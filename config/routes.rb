Rails.application.routes.draw do
  
  # 会員側のルーティング設定
  root to: "/"
  root to: "/about"
  
  devise_for :customer, skip:[:passwords], controllers:{
    registrations: "customer/registrations",
    sessions: "customer/sessions"
  }
  
  # 管理者側のルーティング設定
  namespace :admin do
    devise_for :admin, skip:[:registrations, :passwords], controllers:{
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: 'homes/top'
    resources :products, except:[:destroy]
    resources :genres, only:[:index, :edit, :create, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :orders, only:[:index, :show, :update]
    resources :order_details, only:[:update]
  end
  
  
  
  
  
  end

end
