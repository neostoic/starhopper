module MessagesHelper
	def reply
		@reply = Message.new(message_params)
		if @message.save
			flash[:notice] = "Message was sent successfully."
			redirect_to messages_index_path
		else
			flash[:alert] = "There was a problem sending your message."
			redirect_to messages_new_path
		end
	end
end
