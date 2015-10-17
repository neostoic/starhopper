class UserChat < ActiveRecord::Base
	belongs_to :user
	belongs_to :chat
	has_many :messages, :through => :chat

	accepts_nested_attributes_for :chat

	delegate :subject, :to => :chat
	delegate :users, :to => :chat

	attr_accessor :to
	before_create :create_user_chats

	private

	def create_user_chats
		return if to.blank?

		to.each do |recip|
			UserChat.create :user_id => recip, :chat => chat
		end
	end
end
