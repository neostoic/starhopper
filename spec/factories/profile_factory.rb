FactoryGirl.define do

	factory :valid_profile, class: User do
		birthday "01-01-1990"
		gender "Male"
		bio "My bio"
		created_at Time.now
		updated_at Time.now	
	end

	factory :invalid_profile, class: User do
		birthday nil
		gender "Male"
		bio "My bio"
		created_at Time.now
		updated_at Time.now	
	end


end

