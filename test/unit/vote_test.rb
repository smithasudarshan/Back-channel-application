require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  vote1 = Vote.new(:post_id => 1, :user_id => 1)
  vote2 = Vote.new(:post_id => 2, :user_id => 2)

  def test_truth
    assert true
  end

  test "should require all fields" do
    assert_false vote1.valid?
  end

  test "unique post id for every user" do
     assert_not_equal vote1, vote2
  end
end
