class Accesstoken < ApplicationRecord
	belongs_to	:strava_athlete
	belongs_to 	:user
	
end
