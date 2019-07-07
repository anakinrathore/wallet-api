class WalletsController < ApplicationController

  def create
    @user = User.find_by_id(params[:user_id])
    if @user
      @user.wallet = Wallet.create(balance_in_paise: params[:balance_in_paise])
      render_wallet_created_success_message
    else
      render_user_not_found_message
    end
  end

  def deposit
    @user = User.find_by_id(params[:user_id])
    if @user
      if @user.wallet.present?
        @user.wallet.deposit(params[:deposit_amount])
        render_wallet_updated_message
      else
        render_wallet_not_found_message
      end
    else
      render_user_not_found_message
    end
  end

  def withdraw
    @user = User.find_by_id(params[:user_id])
    if @user
      if @user.wallet.present?
        @user.wallet.withdraw(params[:withdrawl_amount])
        render_wallet_updated_message
      else
        render_wallet_not_found_message
      end
    else
      render_user_not_found_message
    end
  end

  def render_user_not_found_message
    render json:{ "success": false, "errors": "User with id: #{params[:user_id]} not found" }, status: :bad_request
  end

  def render_wallet_created_success_message
    render json: @user.wallet, status: :created
  end

  def render_wallet_updated_message
    render json: @user.wallet, status: 200
  end

  def render_wallet_not_found_message
    render json: { "success": false, "errors": "Wallet not found for user with id: #{params[:user_id]}" }, status: :bad_request
  end
end
