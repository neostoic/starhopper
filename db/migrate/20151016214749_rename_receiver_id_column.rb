class RenameReceiverIdColumn < ActiveRecord::Migration
  def change
  	rename_column :messages, :receiver_id, :chat_id
  end
end
