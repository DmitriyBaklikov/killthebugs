class CreateFragments < ActiveRecord::Migration
  def change
    create_table :fragments do |t|
      t.string :title
      t.text :code
      t.boolean :is_public
      t.string :hashie
      t.boolean :has_bugs

      t.timestamps
    end
  end
end
