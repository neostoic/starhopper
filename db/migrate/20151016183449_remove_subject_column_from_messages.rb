class RemoveSubjectColumnFromMessages < ActiveRecord::Migration
  def change
  	remove_column :messages, :subject, :string
  end
end
