require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    assert_no_difference 'User.count' do
      post_via_redirect user_registration_path, user: { username:  "",
                                                   email:     "user@invalid",
                                                   password:              "foo",
                                                   password_confirmation: "bar" }
    end
    #assert_template 'static_pages/about'
  end

  test "valid signup information" do
    assert_difference 'User.count', 1 do
      post_via_redirect user_registration_path, user: { username:  "Example User",
                                            email:     "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password" }
    end
  end
end
