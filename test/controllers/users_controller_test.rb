require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
<<<<<<< HEAD
=======
  test "should get index" do
    get users_index_url
    assert_response :success
  end

>>>>>>> master
  test "should get show" do
    get users_show_url
    assert_response :success
  end
end
