require 'rails_helper'

RSpec.describe Profile, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  valid_profile_attributes = FactoryGirl.attributes_for(:valid_profile)
  

  describe "is invalid without a" do
  	let(:profile){ Profile.new(valid_profile_attributes) } 

  	it "gender" do
  		profile.gender = nil
  		expect(profile).to be_invalid
  	end

  end
end