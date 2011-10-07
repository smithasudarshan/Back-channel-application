require File.dirname(__FILE__) + '/../test_helper'

class UserFlow < ActionDispatch::IntegrationTest
  fixtures :all

  test "login and browse site" do
    # login via https
    https!
    get "users/index"
    assert_response :success

    post_via_redirect "posts/index", :username => "gmahesh", :password => "loveone"
    assert_response :success




  end

  # test "the truth" do
  #   assert true
  # end
end
