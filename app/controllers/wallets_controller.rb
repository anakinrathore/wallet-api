class WalletsController < ApplicationController

  def create
    @user = User.find_by_id(params[:user_id])
    if @user
      @user.wallet = Wallet.create(balance_in_paise: params[:balance_in_paise])
      render json: @user.wallet, status: :created
    else
      render json:{ "success": false, "errors": "User with id: #{params[:user_id]} not found" }, status: :bad_request
    end
  end
end
