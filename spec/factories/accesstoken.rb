require 'faker'

FactoryGirl.define do
	factory :accesstoken do
		strava_athlete
		athlete_access_token  { Faker::Crypto.md5 }
		access_token_valid		true
	end
		
	
end
