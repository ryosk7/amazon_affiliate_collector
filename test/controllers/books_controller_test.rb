require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  test "should get serch" do
    get books_serch_url
    assert_response :success
  end

end
