class CreateSharing < ActiveRecord::Migration
  def up
    drop_table :fragments_users
    create_table :sharings do |t|

      t.integer :user_id
      t.integer :fragment_id

    end
  end

  def down
  end
end
