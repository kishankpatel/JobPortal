class CandidateController < ApplicationController
  def index
    @jobs = current_user.organization.jobs
  end
  def invite
    candidate = Candidate.find_by_id(params[:id])
    if candidate.present?
      Notification.invite(candidate.email).deliver
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Invitation sent for interview to: #{candidate.email}" }
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, alert: "Candidate not found with id: #{params[:id]}" }
      end
    end
  end
end
