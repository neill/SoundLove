class User < ActiveRecord::Base

  TEMP_EMAIL_PREFIX = 'soundlove'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:soundcloud]

    def self.find_for_soundcloud(auth, signed_in_resource=nil)
        data = auth.info
        user = User.find_by(email: data.email)
        if user
            user.name = auth.info.name
            user.provider = auth.provider
            user.uid = auth.uid
            user.token = auth.credentials.token
            user.save
            user
        else
            user = User.new(
                name: auth.info.name,
                email: auth.email ? data.email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}@#{auth.provider}.com",
                password: Devise.friendly_token[0,20],
                provider: auth.provider,
                uid: auth.uid,
            )
            user.save!
        end
        user
    end
end