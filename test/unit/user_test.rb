require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

    user1 = User.new(:fullname => "User 1", :username => "user1", :password => "user1", :role=> "User")
    user2 = User.new(:fullname => "User 2", :username => "user2", :password => "user2", :role => "User")
    user3 = User.new(:fullname => "User 3", :username => "user3", :password => "use3")
    user4 = User.new(:fullname => "User 4", :username => "user4", :password => "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")

    def test_truth
      assert true
    end

    test "should require all fields" do
      assert_false user3.valid?
    end

    test "unique username for every user" do
       assert_not_equal user1.to_s, user2.to_s
    end

    test "length of short password" do
       assert !user3.save

    end

    test "length of long password" do
      assert !user4.save
    end

    test "valid user" do
      assert user1
    end

    test "check for a nil value for the role of the user" do
      assert_not_nil(User.find_all_by_role("User 2"))
    end

    test "create update delete" do
      user5 = User.new(:fullname => "User 5", :username => "user5", :password => "user5", :role => "User")
      assert user5.save
      user6 = User.find_by_fullname(user5.fullname)
      assert_equal user5.fullname, user6.fullname
      assert user6.save
      assert user6.destroy
    end

end
