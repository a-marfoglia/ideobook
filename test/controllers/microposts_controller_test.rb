require 'test_helper'

class MicropostsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end
