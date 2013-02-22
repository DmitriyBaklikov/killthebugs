class SomeNewFields < ActiveRecord::Migration
  def up
    add_column :fragments, :user_id,  :integer
    add_column :fragments, :language, :string
  end

  def down
  end
end
