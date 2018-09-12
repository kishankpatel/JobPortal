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

end
