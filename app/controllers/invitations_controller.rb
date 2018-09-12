class InvitationsController < ApplicationController
  skip_before_action :authenticate_user!

   def accept
    invitation = Invitation.find_by_id(params[:id])
    if invitation.present?
      invitation.update_attribute :is_accepted, true
      flash[:notice] = "Thank you for your intrest."
    end
    redirect_to root_path
  end

  def reject
    @invitation = Invitation.find_by_id(params[:id])
  end

  def reject_job
    invitation = Invitation.find_by_id(params[:id])
    if invitation.present?
      invitation.update_attributes(:is_accepted => false, :rejected_reason => params[:invitation][:rejected_reason])
      flash[:notice] = "Thank you for your feedback."
    end
    redirect_to root_path
  end
end