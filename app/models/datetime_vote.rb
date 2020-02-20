class DatetimeVote < ApplicationRecord
  belongs_to :user
  belongs_to :datetime_option
end
