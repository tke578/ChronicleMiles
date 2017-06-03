require 'rails_helper'
require 'spec_helper'

RSpec.describe WelcomeController, type: :controller do
	let(:user) { double('user')}
	let(:authenticate) { allow(request.env['warden']).to receive(:authenticate!).and_return(user)}
	let(:current_user) { allow(controller).to receive(:current_user).and_return(user)}
	describe "GET#token_exchange" do
		context "if params error is present" do
			it "will redirect to action access_denied with a flash message" do
				authenticate
				current_user
				get :token_exchange, params: { error: true }
				expect(response).to redirect_to access_denied_path
				expect(flash[:notice]).to match(/Sorry! Looks like access was not granted!/)
			end
		end
		context "if params code is present" do
			it "will redirect to index action with a flash message" do
				allow(controller).to receive(:strava_credentials_request).and_return(true)
				allow(controller).to receive(:find_or_create_access_token).and_return(true)
				authenticate
				current_user
				get :token_exchange, params: { code: true}
				expect(response).to redirect_to home_index_path
				expect(flash[:notice]).to match(/Wohoo Access has been granted!/)
			end
		end
		context "if the successful exchange is given" do
			it "a new welcome instance will be instaniated" do
				allow(controller).to receive(:strava_credentials_request).and_return(true)
				authenticate
				current_user
				# expect{
				# 	get :token_exchange
				# 	expect
				# }
			end
		end
	end

	# describe "GET strava_credentials_request" do

		

	# 	before(:each) do
	# 		controller.stub(:strava_credentials_request).and_return(true)
	# 		@response_json = {"access_token" => "abcd123efg456", 
	# 													"athlete" => { "id" => 123456, "first_name" => "Jose", "last_name" =>	"Smiths",
	# 															"profile" => "something.jpg", "city" => "San Francisco", "state" => "CA",
	# 															"country" => "USA", "sex" => "Male", "created_at" => "11/20/1986", 
	# 															"athlete_type" => "Running", "date_preference" => "Month, day, year",
	# 															"measurement_preference" => "Feet", "email" => "123@yahoo.com"}}
			

	# 	end

	# 	describe "if the authentication is denied" do
	# 		it "redirects to the access denied page" do
	# 			get :token_exchange, params: { error: true }
				
	# 			expect(response).to redirect_to access_denied_path
	# 		end
	# 	end

	# 	describe "if the authentication is successful" do

	# 		context "if the code params is present" do
	# 			it "redirects to the access_granted action" do
	# 				get :token_exchange, params: { code: true }

	# 				expect(response).to redirect_to access_granted_path
	# 			end
	# 		end

	# 		context "if its a new user" do
	# 			it "it saves the access token and athlete info" do
	# 				@new_response = Welcome.new(@response_json)

	# 				expect{@new_response.verify_athlete_existence}.to change{StravaAthlete.count}.by(1)
	# 			end
	# 		end

	# 		context "if the strava athlete is found but the requested access token does not match" do
	# 			it "sets the previous access token to invalid and saves the new access token" do
	# 				old_token = FactoryGirl.create(:accesstoken)
	# 				response_athlete_id = @response_json["athlete"]["id"]
	# 				old_token.strava_athlete.update(:athlete_id => response_athlete_id)
	# 				@new_response = Welcome.new(@response_json)
	# 				@new_response.verify_athlete_existence
	# 				old_token.reload

	# 				expect(old_token.access_token_valid).to be(false)
	# 			end
	# 		end

	# 		context "if a user exists and access token is valid" do
	# 			it "returns the athlete" do
	# 				old_token = FactoryGirl.create(:accesstoken)
	# 				@response_json["access_token"] = old_token.athlete_access_token
	# 				@response_json["athlete"]["id"] = old_token.strava_athlete.athlete_id
	# 				@new_response = Welcome.new(@response_json)

	# 				expect(@new_response.verify_athlete_existence).to be(nil)		
	# 			end
	# 		end
	# 	end
	# end
end
