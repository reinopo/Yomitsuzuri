require "test_helper"

class FavoriteAuthorsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get favorite_authors_create_url
    assert_response :success
  end

  test "should get destroy" do
    get favorite_authors_destroy_url
    assert_response :success
  end
end
