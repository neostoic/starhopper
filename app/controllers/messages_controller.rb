class MessagesController < ApplicationController
  def index
    @messages = Message.where(user_id: current_user.id)
  end

  def new
    @message = Message.new
  end

  def create
    @message = User.new(message_params)
    if @user.save
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
    allow = :user_id, :receiver_id, :subject, :message
    params.require(:user).permit(allow)
  end
end
