class Chat < ActiveRecord::Base
	has_many :user_chats
	has_many :users, :through => :user_chats
	has_many :messages

	accepts_nested_attributes_for :messages
	
end
