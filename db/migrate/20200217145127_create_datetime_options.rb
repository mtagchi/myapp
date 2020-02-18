class CreateDatetimeOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :datetime_options do |t|
      t.date :date, null: false
      t.time :start_time
      t.time :end_time
      t.references :event
      t.timestamps
    end
  end
end
