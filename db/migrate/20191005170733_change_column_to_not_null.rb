class ChangeColumnToNotNull < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :name, :string, null: true
    change_column :users, :image, :string, null: true
  end

  def down
    change_column :users, :name, :string, null: false
    change_column :users, :image, :string, null: false
  end
end
