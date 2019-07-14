class GroupsController < ApplicationController

  def create
    user = User.find_by_id params[:user_id]
    @group = Group.create(kind: params[:kind]) if params.require(:kind)
    @group.users << user
    render json: @group, status: :created and return unless @group.errors.present?
    render json: { "success": false, "errors": @group.errors }, status: 500
  end
end
