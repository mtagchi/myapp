require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      email: "test@example.com",
      password: "foobar",
      provider: "twitter",
      uid: "123456",
      name: "test_user",
      image: Rack::Test::UploadedFile.new(Rails.root.join('test', 'fixtures', 'files', 'images', 'test.png'), 'image/png'),
      username: "testuser"
    )
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "  "
    assert_not @user.valid?
  end

  test "image should be present" do
    @user.image = nil
    assert_not @user.valid?
  end

  test "username should be present" do
    @user.username = "  "
    assert_not @user.valid?
  end

  test "event should be destroyed when host user destroyed" do
    @user.save
    @user.events.create!(
      title: "Sample Event",
      date: "2019-05-15",
      start_time: "19:00",
      end_time: "21:00",
      no_of_participants: 4,
      text: "sushi party!!!",
      restaurant_name: "jiro-sushi",
      address: "Ginza",
      restaurant_url: "https://railstutorial-ja.herokuapp.com"
    )
    assert_difference "Event.count", -1 do
      @user.destroy
    end
  end
end
