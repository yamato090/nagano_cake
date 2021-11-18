Rails.application.routes.draw do

  # 管理者側のルーティング設定
    devise_for :admin, skip:[:registrations, :passwords], controllers:{
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: 'homes#top'
    resources :products, except:[:destroy]
    resources :genres, only:[:index, :edit, :create, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :orders, only:[:index, :show, :update]
    resources :order_details, only:[:update]
  end

  # 会員側のルーティング設定
  root to: "public/homes#top"

  devise_for :customer, skip:[:passwords], controllers:{
    registrations: "customer/registrations",
    sessions: "customer/sessions"
  }

  scope module: :public do
    get "/about", to: "homes#about"
    get "/customers/quit", to: "customers#quit"
    patch "/customers/out", to: "customers#out"
    resource :customers, only:[:show, :edit, :update]
    resources :products, only:[:index, :show]
    resources :cart_products, except:[:show, :new, :edit]
    delete "/cart_products", to: "cart_products#destroy_all"
    resources :orders, except:[:edit, :update, :destroy] do
      collection do
        get "complete"
        post "check"
      end
    end
    resources :deliveries, except:[:new, :show]
  end
end