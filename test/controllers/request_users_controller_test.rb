require 'test_helper'

class RequestUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get request_users_new_url
    assert_response :success
  end

end
