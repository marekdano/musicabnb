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

  def stripe_connect
    @member = current_member
    if @member.update_without_password({
        provider: request.env["omniauth.auth"].provider,
        stripe_user_id: request.env["omniauth.auth"].uid,
        stripe_access_token: request.env["omniauth.auth"].credentials.token,
        stripe_refresh_token: request.env["omniauth.auth"].credentials.token,
        stripe_publishable_key: request.env["omniauth.auth"].info.stripe_publishable_key
    })

      # anything else you need to do in response..
      redirect_to member_locations_path, notice: "Congrats on connecting your Stripe account!"
    else
      redirect_to payout_account_member_path(current_member), alert: "Please connect to Stripe before you can continue."
    end
  end

end
