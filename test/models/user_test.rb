require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "email should be valid" do
    @user.email = "ff@e."
    assert_not @user.valid?
    @user.email = " "
    assert_not @user.valid?
    @user.email = "marco"
    assert_not @user.valid?
    @user.email = "fico@lol..it"
    assert_not @user.valid?
  end

  test "username should be present" do
    @user.username = "  "
    assert_not @user.valid?
  end

end
