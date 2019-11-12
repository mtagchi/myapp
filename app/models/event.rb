class Event < ApplicationRecord
  belongs_to :user, foreign_key: "host_user_id"
  has_many :event_tags, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :tags, through: :event_tags
  has_many :comments
  validates :title, presence: true
  validates :date, presence: true
  validates :text, presence: true
  attr_writer :current_step

  def current_step
    @current_step || steps.first
  end

  def steps
    %w[first confirmation]
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
    current_step == steps.last
  end

  def all_valid?
    steps.all? do |step|
      current_step = step
      valid?
    end
  end

  def save_tags(tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    new_tags.each do |new_name|
      event_tag = Tag.find_or_create_by(name: new_name)
      self.tags << event_tag
    end
  end
end
