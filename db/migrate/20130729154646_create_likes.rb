class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :movie_id
      t.integer :user_id

      t.timestamps
    end

    add_index :likes, [ :user_id, :movie_id ], :unique => true
  end
end
