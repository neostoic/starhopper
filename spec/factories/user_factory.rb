FactoryGirl.define do
  factory :valid_user, class: User do
  	first_name "Zach"
  	last_name "Krzyzanowski"
  	email "zkrzyz@gmail.com"
  	password "12345678"
  	password_confirmation "12345678"
  	created_at Time.now
  	updated_at Time.now	
  end

  factory :invalid_user, class: User do
  	first_name nil
  	last_name "Krzyzanowski"
  	email "zkrzyz@gmail.com"
  	password "12345678"
    password_confirmation "12345678"
  	created_at Time.now
  	updated_at Time.now	
  end

  factory :other_user, class: User do
  	first_name "Other"
  	last_name "User"
  	email "other@user.com"
  	password "12345678"
    password_confirmation "12345678"
  	created_at Time.now
  	updated_at Time.now	
  end
end
