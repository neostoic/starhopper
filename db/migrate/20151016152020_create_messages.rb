class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :receiver_id
      t.string :subject
      t.string :message

      t.timestamps null: false
    end
  end
end
