class CandidateController < ApplicationController
  def index
    @jobs = current_user.organization.jobs
  end

  def invite
    @invitation = Invitation.new
  end

  def send_invitation
    candidate = Candidate.find_by_id(params[:candidate_id])
    job = Job.find_by_id(params[:job_id])
    if candidate.present?
      interview_date = DateTime.strptime(params[:invitation][:interview_date], '%d/%m/%Y - %H:%M') # params[:candidate][:interview_date]
      invitation = Invitation.create(:candidate_id => candidate.id, :organization_id => current_user.organization.id, :job_id => params[:job_id], :interview_date => interview_date)
      begin
        NotificationMailer.invite(candidate,job,invitation).deliver_now
        respond_to do |format|
          format.html { redirect_to root_path, notice: "Invitation sent for interview to: #{candidate.email}" }
        end
      rescue Exception => e
        respond_to do |format|
          format.html { redirect_to root_path, alert: e.message }
        end     
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, alert: "Candidate not found with id: #{params[:candidate_id]}" }
      end
    end
  end
end
