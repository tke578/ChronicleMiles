class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]
    has_many :accesstokens
    has_one :valid_access_token, -> { where access_token_valid: true },
                              class_name: "Accesstoken"
    
  	def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	    user.email = auth.info.email
	    user.password = Devise.friendly_token[0,20]
	    user.name = auth.info.name || ''
	    user.uid = auth.uid
	    user.provider = auth.provider
	    user.skip_confirmation!
	  end
	end
end
