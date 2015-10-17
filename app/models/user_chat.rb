class UserChat < ActiveRecord::Base
	belongs_to :user
	belongs_to :chat
	has_many :messages, :through => :chat

	accepts_nested_attributes_for :chat

	delegate :subject, :to => :chat
	delegate :users, :to => :chat

	private

	def create_user_conversations
		return if to.blank?

		to.each do |recip|
			UserConversation.create :user_id => recip, :conversation => conversation
		end
	end
end
