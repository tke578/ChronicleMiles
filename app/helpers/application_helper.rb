module ApplicationHelper

	def strava_auth(client_id)
		"https://www.strava.com/oauth/authorize?client_id=#{client_id}&response_type=code&redirect_uri=http://localhost:3000/token_exchange"
	end
end
