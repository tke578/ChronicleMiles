class WelcomeController < ApplicationController
	before_action :authenticate_user!, except: [:index, :home]

	def index
		@client_id = ENV['STRAVA_API_CLIENT_ID'] unless current_user.valid_access_token
	end

	def home 
	end

	def token_exchange
		if params[:error]
			redirect_to action: "access_denied" 
			flash[:notice] = "Sorry! Looks like access was not granted!"
		elsif params[:code]
			session[:code] = params[:code] || ''
			strava_credentials_request
			find_or_create_access_token
			redirect_to action: "index"
			flash[:notice] = "Wohoo Access has been granted!"
		end
	end
	

	def access_denied
	end

	def find_or_create_access_token
		welcome = Welcome.new(@response_json, current_user)
		welcome.verify_athlete_existence
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

end
