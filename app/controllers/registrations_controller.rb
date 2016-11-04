class RegistrationsController < Devise::RegistrationsController
  
  def create 
    super
    if resource.save
      resource.create_profile
    end
  end

  private

  def sign_up_params
    params.require(:member).permit(:name, :email, :password, :password_confirmation)
  end

end