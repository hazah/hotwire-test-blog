require "test_helper"

class LandingPageControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get root_url
    assert_response :success
  end
end
