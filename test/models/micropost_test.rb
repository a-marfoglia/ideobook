require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @category = categories(:one)
    # This code is not idiomatically correct.
    @micropost = @user.microposts.build(title: "Lorem", content: "Lorem ipsum", category: @category)
  end

  test "should be valid" do
    assert @micropost.valid?
  end

  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "content should be present " do
    @micropost.content = "   "
    assert_not @micropost.valid?
  end

  test "content should be at most 301 characters" do
    @micropost.content = "a" * 301
    assert_not @micropost.valid?
  end

  test "category should be present" do
    @micropost.category = nil
    assert_not @micropost.valid?
  end

end
