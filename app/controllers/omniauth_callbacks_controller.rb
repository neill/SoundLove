class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def soundcloud
        @user = User.find_for_soundcloud(request.env["omniauth.auth"], current_user)

        if @user.persisted?
          sign_in_and_redirect @user, event: :authentication
          flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Soundcloud"
        else
          redirect_to new_user_registration_url, notice: 'Access Denied'
        end
    end
end