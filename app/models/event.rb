class Event < ApplicationRecord
  belongs_to :user, foreign_key: "host_user_id"
  validates :title, presence: true
  validates :date, presence: true
  validates :text, presence: true
  attr_writer :current_step
  acts_as_taggable

  def current_step
    @current_step || steps.first
  end

  def steps
    %w[first second confirmation]
  end

  def next_step
    self.current_step = steps[steps.index(current_step) + 1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step) - 1]
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last?
  end

  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end
end
