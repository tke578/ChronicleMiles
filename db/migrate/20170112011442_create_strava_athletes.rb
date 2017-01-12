class CreateStravaAthletes < ActiveRecord::Migration[5.0]
  def change
    create_table :strava_athletes do |t|
    	t.integer	:athlete_id
    	t.string	:first_name
    	t.string	:last_name
    	t.string	:profile
    	t.string	:city
    	t.string	:state
    	t.string	:country
    	t.string	:sex
    	t.datetime	:account_created
    	t.integer	:athlete_type
    	t.string	:date_preference
    	t.string	:measurement_preference
    	t.string	:email

      t.timestamps
    end
  end
end
