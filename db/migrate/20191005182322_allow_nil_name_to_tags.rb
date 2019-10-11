class AllowNilNameToTags < ActiveRecord::Migration[6.0]
  def up
    change_column :tags, :name, :string, null: true
  end

  def down
    change_column :tags, :name, :string, null: false
  end
end
