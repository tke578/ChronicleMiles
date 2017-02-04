class BuildsStravaAthlete

	def initialize(request_response)
		@request_response = request_response
	end

	def setup

		new_athlete = StravaAthlete.new(athlete_id: @request_response["id"], first_name: @request_response["firstname"], last_name: @request_response["lastname"],
		 								profile: @request_response["profile"], city: @request_response["city"], state: @request_response["state"], country: @request_response["country"],
		 								sex: @request_response["sex"], account_created: @request_response["created_at"], athlete_type: @request_response["athlete_type"],
		 								date_preference: @request_response["date_preference"], measurement_preference: @request_response["measurement_preference"],
		 								email: @request_response["email"])
		return new_athlete
	end
end