require 'test_helper'

class RequestPostJobsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get request_post_jobs_new_url
    assert_response :success
  end

end
