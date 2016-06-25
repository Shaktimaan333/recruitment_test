require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "Quiz"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Help | Quiz"
  end

  test "should get about" do
  	get :about
  	assert_response :success
  	assert_select "title", "About | Quiz"
  end
  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "Contact | Quiz"
  end
  test "should get faq" do
    get :faq
    assert_response :success
    assert_select "title", "FAQ | Quiz"
  end

end
