require 'test_helper'

class CreateUserFromMainPageTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "create user  from the main page" do
    visit(users_path)
    click_link("Sign Up")
    fill_in('user_fullname',:with=>"My Name")
    fill_in('user_username',:with=>"My UserName")
    fill_in('user_password',:with=>"My Password")
    click_button("Create User")
    get_via_redirect "users/index"
    post_via_redirect "posts/index", :username =>"My Name", :password =>"My Password"





    end

  # test "the truth" do
  #   assert true
  # end
end
