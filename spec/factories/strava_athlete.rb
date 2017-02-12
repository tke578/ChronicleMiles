require 'faker'

FactoryGirl.define do
	factory :strava_athlete do
		
		
			athlete_id			{ Faker::Number.number(4) }
			first_name			{ Faker::Name.first_name }
 			last_name			{ Faker::Name.last_name }
 			city				{ Faker::Address.city}
 			state 				{ Faker::Address.state }
 			sex					"male"
 			country				{ Faker::Address.country }
 			created_at			{ Faker::Date.backward(300) }
 			athlete_type 		1
 			date_preference 	"m/d/Y"
 			measurement_preference "feet"
 			email				{ Faker::Internet.email }
 			updated_at			{ Faker::Date.backward(10) }
		
	end
	
end