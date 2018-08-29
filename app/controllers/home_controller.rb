class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    if user_signed_in? 
      if current_user.role == "org_user"
        @jobs = current_user.organization.jobs.order("created_at DESC")
      else
        @jobs = Job.all.order("created_at DESC")
      end
    else
      @jobs = Job.all.order("created_at DESC").approved
    end
  end
  def create_candidate
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


  private
  def candidate_params
    params.require(:candidate).permit(:name, :email)
  end
end
