class Model < ActiveRecord::Migration[5.0]
  def change
  	create_table :strava_activities do |t|
  		t.integer :activity_id
  		t.integer :resource_state
  		t.string  :external_id
  		t.string  :upload_id
  		t.text 	  :athlete
  		t.string  :name
  		
  	end
  end
end
