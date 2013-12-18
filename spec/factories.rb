FactoryGirl.define do 
	factory :order do
		name  "Dustin Schaerer"       
		ship_street_address "123 Way Street"
    	ship_city           "Vancouver"
    	ship_state          "Washington" 
    	ship_country        "United States"
        telephone           "555-555-5555"
    	email               "test@gmail.com"
	end

	
end