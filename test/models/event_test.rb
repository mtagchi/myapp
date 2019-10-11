require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @user = users(:john)
    @event = @user.events.build(
      title: "Sample Event",
      date: 2019-05-15,
      start_time: "19:00",
      end_time: "21:00",
      no_of_participants: 4,
      text: "sushi party!!!",
      restaurant_name: "jiro-sushi",
      address: "Ginza",
      restaurant_url: "https://railstutorial-ja.herokuapp.com"
    )
  end

  test "should be valid" do
    assert @event.valid?
  end

  test "title should be present" do
    @event.title = "  "
    assert_not @event.valid?
  end

  test "date should be present" do
    @event.date = "  "
    assert_not @event.valid?
  end

  test "text should be present" do
    @event.text = "  "
    assert_not @event.valid?
  end
end
