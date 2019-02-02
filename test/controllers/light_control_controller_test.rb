require 'test_helper'

class LightControlControllerTest < ActionController::TestCase
  test "should get on" do
    get :on
    assert_response :success
  end

  test "should get of" do
    get :of
    assert_response :success
  end

  test "should get blink" do
    get :blink
    assert_response :success
  end

  test "should get random" do
    get :random
    assert_response :success
  end

end
