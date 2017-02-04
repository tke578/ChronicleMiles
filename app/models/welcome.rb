class Welcome
	def initialize(request_body)
		@request_body = request_body
		@access_token = @request_body["access_token"]
		@athlete = @request_body["athlete"]
		@athlete_id = @request_body["athlete"]["id"]
	end

	def verify_athlete_existence
		@find_athlete_token = Accesstoken.where(athlete_access_token: @access_token, access_token_valid: true).first
		@find_athlete = StravaAthlete.where(athlete_id: @athlete_id).first
		
		if new_athlete?
			save_access_token_and_athlete
		elsif old_token_is_invalid?
			set_previous_token_to_invalid
			create_token
		elsif returning_athlete?
			return
		end
	end

	def new_athlete?
		@find_athlete_token.nil? && @find_athlete.nil?
	end

	def old_token_is_invalid?
		@find_athlete_token.nil? && @find_athlete.accesstokens.exists?
	end

	def returning_athlete?
		!@find_athlete_token.nil?
	end

	private

	def set_previous_token_to_invalid
		@find_athlete_token.update(access_token_valid: false)
	end

	def create_token
		Accesstoken.create(athlete_access_token: @access_token, access_token_valid: true)
	end

	def build_access_token
		Accesstoken.new(athlete_access_token: @access_token, access_token_valid: true)
	end

	def save_access_token_and_athlete
		builds_athlete = BuildsStravaAthlete.new(@athlete)
		map_athlete = builds_athlete.setup
		map_athlete.save
		athlete_access_token = build_access_token
		athlete_access_token.strava_athlete = map_athlete
		athlete_access_token.save
	end
end