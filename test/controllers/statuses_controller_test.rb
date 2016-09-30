require 'test_helper'

class StatusesControllerTest < ActionDispatch::IntegrationTest
  setup do
  end

  test "should get index" do
    get '/'
    assert_response :success
  end
end
