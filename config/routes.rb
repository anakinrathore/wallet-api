Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: :create
  resources :wallets, only: [:create] do
    put 'deposit' => 'wallets#deposit', on: :collection, as: :deposit
    put 'deposit_shared' => 'wallets#deposit_shared', on: :collection, as: :deposit_shared
    put 'withdraw' => 'wallets#withdraw', on: :collection, as: :withdraw
    put 'withdraw_shared' => 'wallets#withdraw_shared', on: :collection, as: :withdraw_shared
    post 'create_shared' => 'wallets#create_shared',on: :collection, as: :create_shared
  end
  resources :groups, only: :create
end
