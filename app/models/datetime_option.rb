class DatetimeOption < ApplicationRecord
  belongs_to :event
  has_many :datetime_votes, dependent: :destroy
  # validates :date, presence: true
end
