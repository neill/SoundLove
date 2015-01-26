class User < ActiveRecord::Base

  TEMP_EMAIL_PREFIX = 'soundlove'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:soundcloud_oauth2]

    def self.find_for_soundcloud_oauth2(auth, signed_in_resource=nil)
        identity = Identity.find_for_soundcloud_oauth2(auth)
        user = signed_in_resource ? signed_in_resource : identity.user
        data = auth.info
        if user
            user.name = auth.extra.raw_info.name
            user.provider = auth.provider
            user.uid = auth.uid
            user.token = auth.credentials.token
            user.save
            user
        else
            user = User.new(
                name: auth.extra.raw_info.name,
                email: data.email ? data.email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
                password: Devise.friendly_token[0,20],
                provider: auth.provider,
                uid: auth.uid,
            )
            user.skip_confirmation!
            user.save!
        end

        if identity.user != user
            identity.user = user
            identity.save!
        end
        user
    end
end