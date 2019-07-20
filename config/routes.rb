Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: :create
  resources :wallets do
    put 'deposit' => 'wallets#deposit', as: :deposit
    put 'deposit_shared' => 'wallets#deposit_shared', as: :deposit_shared
    put 'withdraw' => 'wallets#withdraw', as: :withdraw
    put 'withdraw_shared' => 'wallets#withdraw_shared', as: :withdraw_shared
    post 'create_shared' => 'wallets#create_shared',on: :collection, as: :create_shared
  end
  resources :groups, only: :create
end
