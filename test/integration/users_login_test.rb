require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  def setup
    @user = users(:john)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      provider: 'twitter',
      uid: '123545',
    })
  end

  test "login and logout" do
    get root_path
    assert_select "a[href=?]", user_twitter_omniauth_authorize_path
    get user_twitter_omniauth_authorize_path
    assert_redirected_to user_twitter_omniauth_callback_path
    follow_redirect!
    assert_redirected_to root_path
    follow_redirect!
    assert_select "a[href=?]", user_twitter_omniauth_authorize_path, count: 0
    assert @user.name
    assert_select "a[href=?]", "https://twitter.com/#{@user.username}"
    assert_select "a[href=?]", destroy_user_session_path
    delete destroy_user_session_path
    follow_redirect!
    assert_select "a[href=?]", user_twitter_omniauth_authorize_path
  end
end
