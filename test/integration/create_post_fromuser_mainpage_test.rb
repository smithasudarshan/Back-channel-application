require File.dirname(__FILE__) + '/../test_helper'

class CreatePostFromUserMainpageTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "create post from the user's post page" do
    get_via_redirect "posts/new"
    post_via_redirect "posts/index", :post=>"MyPost"
    end

  # test "the truth" do
  #   assert true
  # end
end