class UserChatsController < ApplicationController

	def index
		@user = User.find(current_user)
		@chats = @user.user_chats
	end

	def show
		@chat = UserChat.find params[:id]
	end

	def new
		redirect_to users_path unless current_user

		@user = User.find params[:user_id]
		@chat = @user.user_chats.build
		@chat.build_chat.messages.build
	end

	def create
		redirect_to users_path unless current_user

		@chat = UserChat.new(user_chat_params)
		@chat.user = current_user
		@chat.chat.messages.first.user = current_user
		@chat.save!
		redirect_to user_chat_path(current_user, @chat)
	end

	def mark_as_read
		@chat = UserChat.find params[:id]
		@chat.update_attributes :read => true
		redirect_to user_chat_path(current_user, @chat)
	end

	def mark_as_unread
		@chat = UserChat.find params[:id]
		@chat.update_attributes :read => false
		redirect_to user_chat_path(current_user, @chat)
	end

	private

	def user_chat_params
		params.require(:user_chat).permit(:user_id, :chat_id, :deleted, :read)
	end
end

