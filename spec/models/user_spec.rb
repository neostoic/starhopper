require 'rails_helper'

RSpec.describe User, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  valid_user_attributes = FactoryGirl.attributes_for(:valid_user)
  other_user_attributes = FactoryGirl.attributes_for(:other_user)

  describe "is invalid without a" do
  	let(:user){ User.new(valid_user_attributes) } 

  	it "first_name" do
  		user.first_name = nil
  		expect(user).to be_invalid
  	end

  	it "last_name" do
  		user.last_name = nil
  		expect(user).to be_invalid
  	end

  	it "email" do
  		user.email = nil
  		expect(user).to be_invalid
  	end

  end
end