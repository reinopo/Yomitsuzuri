require "test_helper"

class MypagesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get mypages_show_url
    assert_response :success
  end

  test "should get home" do
    get mypages_home_url
    assert_response :success
  end

  test "should get favorites" do
    get mypages_favorites_url
    assert_response :success
  end

  test "should get citations" do
    get mypages_citations_url
    assert_response :success
  end
end
