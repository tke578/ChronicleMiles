require 'rails_helper'
require 'spec_helper'

RSpec.describe WelcomeController, type: :controller do

	describe "GET strava_credentials_request" do

		

		before(:each) do
			controller.stub(:strava_credentials_request).and_return(true)
			@response_json = {"access_token" => "abcd123efg456", 
														"athlete" => { "id" => 123456, "first_name" => "Jose", "last_name" =>	"Smiths",
																"profile" => "something.jpg", "city" => "San Francisco", "state" => "CA",
																"country" => "USA", "sex" => "Male", "created_at" => "11/20/1986", 
																"athlete_type" => "Running", "date_preference" => "Month, day, year",
																"measurement_preference" => "Feet", "email" => "123@yahoo.com"}}
			

		end

		describe "if the authentication is denied" do
			it "redirects to the access denied page" do
				get :token_exchange, params: { error: true }
				
				expect(response).to redirect_to access_denied_path
			end
		end

		describe "if the authentication is successful" do

			context "if the code params is present" do
				it "redirects to the access_granted action" do
					get :token_exchange, params: { code: true }

					expect(response).to redirect_to access_granted_path
				end
			end

			context "if its a new user" do
				it "it saves the access token and athlete info" do
					@new_response = Welcome.new(@response_json)

					expect{@new_response.verify_athlete_existence}.to change{StravaAthlete.count}.by(1)
				end
			end

			context "if the strava athlete is found but the requested access token does not match" do
				it "sets the previous access token to invalid and saves the new access token" do
					old_token = FactoryGirl.create(:accesstoken)
					response_athlete_id = @response_json["athlete"]["id"]
					old_token.strava_athlete.update(:athlete_id => response_athlete_id)
					@new_response = Welcome.new(@response_json)
					@new_response.verify_athlete_existence
					old_token.reload

					expect(old_token.access_token_valid).to be(false)
				end
			end

			context "if a user exists and access token is valid" do
				it "returns the athlete" do
					old_token = FactoryGirl.create(:accesstoken)
					@response_json["access_token"] = old_token.athlete_access_token
					@response_json["athlete"]["id"] = old_token.strava_athlete.athlete_id
					@new_response = Welcome.new(@response_json)

					expect(@new_response.verify_athlete_existence).to be(nil)		
				end
			end
		end
	end
end
