require 'test_helper'

class NotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get notifications_show_url
    assert_response :success
  end

  test "should get destroy" do
    get notifications_destroy_url
    assert_response :success
  end

end
