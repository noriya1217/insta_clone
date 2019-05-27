require 'test_helper'

class FacebookClonesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get facebook_clones_index_url
    assert_response :success
  end

end
