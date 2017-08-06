class Api::V1::BaseController < ApplicationController
  before_action :authenticate_driver!  #authenticate_driver before nulling session, that makes it work
  protect_from_forgery with: :null_session

  
  #skip_before_action :require_login, :current_user, :require_valid_user

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    return api_error(status: 404, errors: 'Not found')
  end
  
  def destroy_session
    request.session_options[:skip] = true
  end

end
