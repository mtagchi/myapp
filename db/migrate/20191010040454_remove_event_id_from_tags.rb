class RemoveEventIdFromTags < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :tags, :events
    remove_reference :tags, :event
  end
end
