class MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :set_member, only: [:edit, :update, :destroy]

  def edit
    if @member.profile
      @profile = @member.profile
    else
      @profile = @member.build_profile
    end
  end

  def update 
    respond_to do |format|
      if @member.update(member_params)
        flash[:notice] = "Profile was updated successfully."
        format.html { redirect_to profile_path }
      else
        flash[:alert] = "Profile was not saved."
        format.html { redirect_to profile_path }
      end
    end
  end

  def destroy
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
