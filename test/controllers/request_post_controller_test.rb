require 'test_helper'

class RequestPostControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get request_post_new_url
    assert_response :success
  end

  test "should get create" do
    get request_post_create_url
    assert_response :success
  end

  test "should get show" do
    get request_post_show_url
    assert_response :success
  end

  test "should get destroy" do
    get request_post_destroy_url
    assert_response :success
  end

end
