require 'test_helper'

class QuesControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  def setup
    @que = ques(:michael)
  end
  test "should get new" do
    get :new, id: @que
    assert_response :success
  end

end
