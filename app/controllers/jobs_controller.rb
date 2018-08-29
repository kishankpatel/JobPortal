class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy, :apply,:approve,:unapprove]
  skip_before_action :authenticate_user!, only: :apply
  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = current_user.organization.jobs.approved
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    if @job.is_archive
      flash[:alert] = "Job has been removed."
      redirect_to root_path
    end
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)
    @job.user_id = current_user.id
    @job.organization_id = current_user.organization_id

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.update_attribute :is_archive, true
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def apply
    @candidate = Candidate.new
    if @job.blank?
      respond_to do |format|
        format.html { redirect_to root_path, alert: "No jobs found with id: #{params[:id]}." }
        format.json { head :no_content }
      end
    end      
  end

  def approve
    @job.update_attribute :is_approve, true   
    flash[:notice] = "Job has been approved."
    redirect_to request.referrer 
  end
  def unapprove
    @job.update_attribute :is_approve, false
    flash[:notice] = "Job has been unapproved."
    redirect_to request.referrer 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:title, :description)
    end
end
