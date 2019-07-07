Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: :create do
    resources :wallets do
      post 'deposit' => 'wallets#deposit', on: :collection, as: :deposit
      post 'withdraw' => 'wallets#withdraw', on: :collection, as: :withdraw
    end
  end
end
