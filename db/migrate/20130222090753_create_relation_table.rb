class CreateRelationTable < ActiveRecord::Migration
  def up
    create_table :fragments_users, :id => false do |t|

      t.integer :fragment_id
      t.integer :user_id

    end
  end

  def down
  end
end
