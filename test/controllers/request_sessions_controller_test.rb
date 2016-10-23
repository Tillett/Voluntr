require 'test_helper'

class RequestSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get request_sessions_new_url
    assert_response :success
  end

end
