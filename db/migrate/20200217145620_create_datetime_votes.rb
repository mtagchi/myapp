class CreateDatetimeVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :datetime_votes do |t|
      t.references :user
      t.references :option, foreign_key: { to_table: :datetime_options }
      t.timestamps
    end
  end
end
