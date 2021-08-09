Rails.application.routes.draw do

  scope module: :public do

    resources :items, only: [:index, :show]

    resource :customers, only: [:edit, :update] do
      collection do
        get :mypage
        get :unsubscribe
        patch :unsubscribe_update
      end
    end

    resources :cart_items, only: [:index, :update, :destroy, :create] do
      collection do
        delete :destroy_all
      end
    end

    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        get :complete
        post :order_valid
        get :confirm
        post :back

      end
    end

    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]

    resources :genres, only: [:index, :create, :edit, :update]

    resources :customers, only: [:index, :show, :edit, :update]

    resources :orders, only: [:show, :update, :index]
  end

    devise_for(
    :end_users,
    path: 'customers',
    module: 'public/customers'
  )

  devise_for(
    :admins,
    path: 'admin',
    module: 'admin/admins'
  )

  patch "admin/orders/details/:id" => "admin/orders#update_items", as: "admin_order_details"
  get "about" => "public/homes#about", as: "home_about"
  get "/" => "public/homes#top", as: "root"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
