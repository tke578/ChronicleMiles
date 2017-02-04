class WelcomeController < ApplicationController
	before_action	:strava_credentials_request, only: [:access_granted]

	def index
		@client_id = ENV['STRAVA_API_CLIENT_ID']
	end

	def token_exchange
		if params[:error]
			redirect_to action: "access_denied" 
			flash[:notice] = "Sorry! Looks like access was not granted!"
		elsif params[:code]
			session[:code] = params[:code] || ''

			redirect_to action: "access_granted"
			flash[:notice] = "Wohoo Access has been granted!"
		end
	end

	def access_granted
		find_or_create_acess_token
		@access_token = Accesstoken.find_by_athlete_access_token(@response_json["access_token"])
	end

	def access_denied
	end

	private

	def strava_credentials_request
		url = 'https://www.strava.com/oauth/token'
		client_id = ENV['STRAVA_API_CLIENT_ID']
		client_secret = ENV['STRAVA_API_CLIENT_SECRET']
		url_params = { 'client_id' => client_id, 'client_secret' => client_secret, 'code' => session[:code] }
		response = HTTParty.post(url, :query => url_params)
		@response_json = JSON.parse(response.body)
	end

	def find_or_create_acess_token
		welcome = Welcome.new(@response_json)
		welcome.verify_athlete_existence
	end

end
