class CreateAccesstokens < ActiveRecord::Migration[5.0]
  def change
    create_table :accesstokens do |t|
    	t.integer	:strava_athlete_id
    	t.string	:athlete_access_token
    	t.boolean	:access_token_valid

      t.timestamps
    end
  end
end
