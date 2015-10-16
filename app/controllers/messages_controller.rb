class MessagesController < ApplicationController
  def index
    @sent_messages = Message.where(user_id: current_user.id)
    @received_messages = Message.where(receiver_id: current_user.id)
    @all_messages = @sent_messages | @received_messages
    @all_messages.sort!

    @reply = Message.new
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      flash[:notice] = "Message was sent successfully."
      redirect_to '/'
    else
      flash[:alert] = "There was a problem sending your message."
      redirect_to messages_new_path
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def message_params
    allow = :user_id, :receiver_id, :body
    params.require(:message).permit(allow)
  end
end
