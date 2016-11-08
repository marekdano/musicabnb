class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @member = Member.from_omniauth(request.env["omniauth.auth"])
    
    if @member.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @member, :event => :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_member_registration_url
    end
  end

  def failure
    redirect_to root_path, alert: "Sorry, you were not able to register or login. Please try again."
  end
end
