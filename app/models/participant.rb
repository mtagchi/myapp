class Participant < ApplicationRecord
  belongs_to :user, foreign_key: "participant_user_id"
  belongs_to :event
end
