class Api::V1::PullsController < Api::V1::ApplicationController
  before_filter :authenticate_user!

  def index
    @pull_requests, @repositories, @users = get_pull_requests
    render 'api/v1/pulls/index'
  end

  def update
    action = "#{action_param}_pull_request".to_sym
    GithubService.new(session[:user_token]).send(action, merge_params, current_user)

    Rails.cache.clear

    render json: { status: :ok }
  end

  private

  def action_param
    params[:kind]
  end

  def merge_params
    params.permit(:id, :repo)
  end

  def get_pull_requests
    GithubService.new(session[:user_token]).get_pull_requests organization
  end

  def organization
    params[:organization] || 'crowdint'
  end

end

