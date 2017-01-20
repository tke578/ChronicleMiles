require 'faker'

FactoryGirl.define do
	factory :successful_authorization do
		access_token			Faker::Crypto.md5	
		# athlete 				{
		# 									"id"					=>	Faker::Number.number(10)
		# 									"first_name" 	=> 	Faker::Number.number(10)
		# 									"last_name"  	=> 	Faker::Name.last_name
		# 								}
	end
	
end