class Users::RegistrationsController < Devise::RegistrationsController

  def create
    organization_name =  params[:user][:organization_name]
    if Organization.find_by_name(organization_name).nil?
      @organization = Organization.new
      @organization.name = organization_name
      @organization.save
    else
      flash[:alert] = "Organization already exists, please try another one."
      redirect_to request.referrer
      return
    end

    params[:user][:organization_id] = @organization.id
    build_resource(registration_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
  end
  end  

  private

  def registration_params
    params.require(:user).permit(:email, :organization_id, :password, :password_confirmation)
  end

end