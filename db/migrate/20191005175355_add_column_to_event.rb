class AddColumnToEvent < ActiveRecord::Migration[6.0]
  def up
    change_column :events, :user, foreign_key: true
  end

  def change
    remove_reference :events, :host_user, foreign_key: { to_table: :users }
  end
end
