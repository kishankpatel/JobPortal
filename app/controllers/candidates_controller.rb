class CandidatesController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @jobs = current_user.organization.jobs
    @candidates = @jobs.include(:candidates)
  end

  def create
    job = Job.find_by_id(params[:job_id])
    if job.present? 
      @candidate = Candidate.find_by_email(params[:candidate][:email])
      p @candidate

      # checking candidate is new or not.
      if @candidate.present?
        # checking candidate already applied to the job or not.
        if @candidate.jobs.where(:id => job.id).first.present?
          respond_to do |format|
            format.html { redirect_to root_path, alert: "You have already applied to this job." }
            format.json { head :no_content }
          end
          return
        end
      else
        @candidate = Candidate.create(candidate_params)
      end
      CandidatesJob.create(:candidate_id => @candidate.id, :job_id => job.id)
      respond_to do |format|
        format.html { redirect_to request.referrer, notice: "You have successfully applied to this job." }
        format.json { head :no_content }
      end
    end
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

  private
  def candidate_params
    params.require(:candidate).permit(:name, :email)
  end
end
