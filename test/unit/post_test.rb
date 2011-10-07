require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
    post1 = Post.new(:post_id => 1, :post => "post1", :user_id => 1)
    post2 = Post.new(:post_id => 2, :post => "post2", :user_id => 2)
    post3 = Post.new(:post_id => 3, :post => "post3", :user_id => 3)
    post4 = Post.new(:post_id => 4, :post => "post4", :user_id => 4)



    def test_truth
      assert true
    end

    test "should require all fields" do
      assert post1.valid?
    end

    test "unique post id for every post" do
       assert_not_equal post1, post2
    end

  test "check for Post 1" do
    assert(Post.find_by_post_id(1))
  end

  test "check for a nil value" do
    assert_not_nil(Post.find_all_by_post("post2"))
  end

  #test "create update delete" do
  #  post5 = Post.new(:post_id => 5, :post => "post5", :user_id => 5)
  #  assert post5.save
  #  post6 = Post.find_by_post_id(post5.post)
  #  assert_equal post5.post, post6.post
  #  assert post6.save
  #  assert post6.destroy
  #end

  test "should not post a nil post" do
    post = Post.new
    assert post.valid?
  end
end
