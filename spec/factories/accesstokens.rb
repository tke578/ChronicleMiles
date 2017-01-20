require 'faker'

FactoryGirl.define do
	factory :valid_access_token do
		strava_athlete_id		Faker::Number.number(10)
		access_token			Faker::Crypto.md5
		access_token_valid		true
	end

	factory :invalid_access_token do
		strava_athlete_id		Faker::Number.number(10)
		access_token			Faker::Crypto.md5
		access_token_valid		false
	end
	
end