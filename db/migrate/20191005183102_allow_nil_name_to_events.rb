class AllowNilNameToEvents < ActiveRecord::Migration[6.0]
  def up
    change_column :events, :title, :string, null: true
    change_column :events, :date, :date, null: true
    change_column :events, :text, :text, null: true
  end

  def down
    change_column :events, :title, :string, null: false
    change_column :events, :date, :date, null: false
    change_column :events, :text, :text, null: false
  end
end
