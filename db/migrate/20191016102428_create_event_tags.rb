class CreateEventTags < ActiveRecord::Migration[6.0]
  def change
    create_table :event_tags do |t|
      t.references :event
      t.references :tag
      t.timestamps
    end
  end
end
