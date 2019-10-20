class AddTagListToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :tag_list, :string
  end
end
