class UsersController < ApplicationController

  def create
    begin
      @user = User.create(validate_params) if validate_params
      render_issue_creation_failure_message if @user.errors.present?
      render_user_creation_success_message if @user
    rescue Exception => e
      render_invalid_or_missing_parameter_message(e.message)
    end
  end

  def render_issue_creation_failure_message
    render json: { "success": false, "errors": @user.errors }, status: 500
  end

  def render_user_creation_success_message
    render json: @user, status: :created
  end

  def render_invalid_or_missing_parameter_message(error_message)
    render json: { "success": false, "errors": error_message }, status: :bad_request
  end

  private

  def validate_params
    params.require(:phone_number)
    params.require(:first_name)
    params.permit(:phone_number, :first_name, :last_name, :email_address)
  end
end
