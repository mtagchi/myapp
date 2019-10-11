class AddHostUserIdToEvents < ActiveRecord::Migration[6.0]
  def change
    remove_reference :events, :user, foreign_key: true
  end

  def change
    add_reference :events, :host_user, foreign_key: { to_table: :users }
  end
end
