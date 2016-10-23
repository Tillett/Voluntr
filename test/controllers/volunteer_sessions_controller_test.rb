require 'test_helper'

class VolunteerSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get volunteer_sessions_new_url
    assert_response :success
  end

end
