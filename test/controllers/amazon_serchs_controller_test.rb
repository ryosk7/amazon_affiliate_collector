require 'test_helper'

class AmazonSerchsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get amazon_serchs_index_url
    assert_response :success
  end

  test "should get show" do
    get amazon_serchs_show_url
    assert_response :success
  end

end
