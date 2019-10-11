class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.date :date, null: false
      t.time :start_time
      t.time :end_time
      t.integer :no_of_participants
      t.text :text, null: false
      t.string :restaurant_name
      t.string :address
      t.string :restaurant_url
      t.references :host_user, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
