class ProfilesController < ApplicationController
  before_action :set_member, :set_profile

  def edit
  end

  def upload_avatar 
    respond_to do |format|
      puts "Profile"
      puts @profile.id
      #binding.pry
      if @profile.update(profile_params)
        flash[:notice] = "Profile was updated successfully."
        format.html { redirect_to profile_path }
      else
        flash[:alert] = "Profile was not saved."
        format.html { redirect_to profile_path }
      end
    end
  end
  
  private

    def set_member
      if current_member
        @member = Member.find(current_member.id)
      else
        @member = Member.find(params[:member_id])
      end
    end

    def set_profile
      if current_member.profile
        @profile = @member.profile
      else
        @profile = @member.create_profile!
      end
    end

    def profile_params
      params.require(:profile).permit(:bio, :member_id, :avatar)
    end
end