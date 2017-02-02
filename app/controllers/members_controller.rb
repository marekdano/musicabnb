class MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :set_member, only: [:update, :update_password, :member_locations]

  def update 
    @profile = @member.profile
    # authorize a member with profile
    authorize @profile
    respond_to do |format|
      if @member.update(member_params)
        flash[:notice] = "Profile was updated successfully."
        format.html { redirect_to profile_path }
      else
        flash[:alert] = "Profile was not saved. #{@member.errors.full_messages.join(" ")}."
        format.html { redirect_to profile_path }
      end
    end
  end

  def update_password
    @profile = @member.profile
    authorize @profile
    if @member.update(member_params)
      # Sign in the member by passing validation in case their password changed
      bypass_sign_in(@member)
      redirect_to profile_path, notice: "Password was successfully changed."     
    else
      redirect_to profile_path, alert: "New password was not saved."
    end
  end

  def member_locations 
    @locations = @member.locations.includes(:location_images)
  end

  def payout_account
  end

  private
  # Use callbacks to share common constraints between actions.
  def set_member
    if current_member 
      @member = Member.find(current_member.id)
    else  
      @member = Member.find(params[:id])
    end
  end

  # Prevent params 
  def member_params
    params
      .require(:member)
      .permit(:name, :email, :password, profile_attributes: [:id, :bio])
  end
end
