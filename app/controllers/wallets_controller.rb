class WalletsController < ApplicationController

  def create
    @user = User.find_by_id(params[:user_id])
    if @user
      @wallet = @user.wallets.create(balance_in_paise: params[:balance_in_paise])
      render_wallet_created_success_message
    else
      render_user_not_found_message
    end
  end

  def create_shared
    @group = Group.find_by_id(params[:group_id])
    if @group
      @wallet = @group.wallets.create(balance_in_paise: params[:balance_in_paise])
      render_wallet_created_success_message
    else
      render_group_not_found_message
    end
  end

  def deposit
    @user = User.find_by_id(params[:user_id])
    if @user.present?
      @wallet = @user.wallets.find_by_id(params[:wallet_id])
      if @wallet.present?
        @wallet.deposit(params[:deposit_amount])
        render_wallet_updated_message
      else
        render_wallet_not_found_message
      end
    else
      render_user_not_found_message
    end
  end

  def deposit_shared
    @user = User.find_by_id(params[:user_id])
    @group = @user.groups.find_by_id(params[:group_id]) if @user.present?
    if @group && @user
      @wallet = @group.wallets.find_by_id(params[:wallet_id])
      if @wallet.present?
        @wallet.deposit(params[:deposit_amount])
        render_wallet_updated_message
      else
        render_wallet_not_found_message
      end
    else
      render json:{ "success": false, "errors": "Group or User with id: #{params[:group_id]} not found" }, status: :bad_request
    end
  end

  def withdraw
    @user = User.find_by_id(params[:user_id])
    if @user
      @wallet = @user.wallets.find_by_id(params[:wallet_id])
      if @wallet.present?
        @wallet.withdraw(params[:withdrawl_amount])
        render_wallet_updated_message
      else
        render_wallet_not_found_message
      end
    else
      render_user_not_found_message
    end
  end

  def withdraw_shared
    @user = User.find_by_id(params[:user_id])
    @group = @user.groups.find_by_id(params[:group_id]) if @user.present?
    if @user && @group
      @wallet = @group.wallets.find_by_id(params[:wallet_id])
      if @wallet
        @wallet.withdraw(params[:withdrawl_amount])
        render_wallet_updated_message
      else
        render_wallet_not_found_message
      end
    else
      render json:{ "success": false, "errors": "Group or User not found" }, status: :bad_request
    end
  end

  def render_user_not_found_message
    render json:{ "success": false, "errors": "User with id: #{params[:user_id]} not found" }, status: :bad_request
  end

  def render_group_not_found_message
    render json:{ "success": false, "errors": "Group with id: #{params[:group_id]} not found" }, status: :bad_request
  end

  def render_wallet_created_success_message
    render json: @wallet, status: :created
  end

  def render_wallet_updated_message
    render json: @wallet, status: 200
  end

  def render_wallet_not_found_message
    render json: { "success": false, "errors": "Wallet not found for user with id: #{params[:user_id]}" }, status: :bad_request
  end
end
