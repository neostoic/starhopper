class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.string :location
      t.string :term
      t.float :rating
      t.integer :radius_filter

      t.timestamps null: false
    end
  end
end
