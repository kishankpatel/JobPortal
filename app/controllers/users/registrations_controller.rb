# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # POST /resource
  def create
    organization = Organization.where(:name => params[:user][:organization]).first
    if organization.present?
      flash[:alert] = "Organization already exists, Please try another one."
      redirect_to request.referrer
      return
    end
    org = Organization.create(:name => params[:user][:organization])
    params[:user][:organization_id] = org.id
    begin
      User.create(
        :email => params[:user],
        :password => params[:password],
        :organization_id => params[:organization_id],
      )
      flash[notice] = "Registrations Successful, please sign in to continue."
      redirect_to root_path
    rescue Exception => e
       flash[:alert] = e.message    
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:email, :password, :organization_id)
  end
end
