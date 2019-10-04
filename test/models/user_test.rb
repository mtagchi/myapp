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
end
