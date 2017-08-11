class Api::V1::SessionsController <  DeviseController
  prepend_before_action :require_no_authentication, :only => [:create ]
  protect_from_forgery with: :null_session

  before_action :ensure_params_exist

  respond_to :json
  
  def create
    resource_class.new
    resource = Driver.find_for_database_authentication(:email=>params[:driver_login][:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:driver_login][:password])
      #sign_in("driver", resource)
      sign_out(resource)
      render :json=> {:success=>true, :auth_token=> JWTWrapper.encode({ driver_id: resource.id }), :email=>resource.email}
      return
    end
    invalid_login_attempt
  end
  
  def destroy
    sign_out(resource_name)
  end

  protected
  def ensure_params_exist
    return unless params[:driver_login].blank?
    render :json=>{:success=>false, :message=>"missing driver_login parameter"}, :status=>422
  end

  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :message=>"Error with your email or password"}, :status=>401
  end
end