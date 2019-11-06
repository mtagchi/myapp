class CreateParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :participants do |t|
      t.references :participant_user, foreign_key: { to_table: :users }
      t.references :event
      t.timestamps
    end
  end
end
