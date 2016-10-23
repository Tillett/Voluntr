require 'test_helper'

class VolunteerUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get volunteer_users_new_url
    assert_response :success
  end

end
