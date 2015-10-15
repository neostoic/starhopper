class AddBirthdayAndGenderColumnToProfileTable < ActiveRecord::Migration
  def change
  	add_column :profiles, :birthday, :date
  	add_column :profiles, :gender, :string
  end
end
