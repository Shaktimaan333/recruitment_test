require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
  	@user = User.new(name: "Example User", email: "example@user.com", password: "foobar", password_confirmation: "foobar", mobileno: "1234567890", classten: "87.65", classtwelve: "94.37", achievements: "achieved this. secured that. Won in this competition", experience: "Worked at this company for these many years and did internship there", projects: "Did this project under thsi proff and was head of this project of this company")
  end
  test "should be valid" do
  	assert @user.valid?
  end
  test "name should not be blank" do
  	@user.name = "     "
  	assert_not @user.valid?
  end
  test "email should not be blank" do
  	@user.email = "     "
  	assert_not @user.valid?
  end
  test "name should not be too long" do
  	@user.name = "a" * 51
  	assert_not @user.valid?
  end
  test "email should not be too long" do
  	@user.email = "a" * 244 + "@example.com"
  	assert_not @user.valid?
  end
  test "email validation should reject invalid addressess" do
  	addressess = %w[user@example,com user_at_foo.org user.name@example.foo@bar_baz.com foo@bar+baz.com]
  	addressess.each do |wer|
  		@user.email = wer
  		assert_not @user.valid?, "#{wer.inspect} should be valid"
  	end
  end
  test "email addresses should be unique" do
	duplicate_user = @user.dup
	duplicate_user.email = @user.email.upcase
	@user.save
	assert_not duplicate_user.valid?
  end
  test "password should have a minimum length" do
  	@user.password_confirmation = @user.password = "a" * 5
  	assert_not @user.valid?
  end
  test "mobileno should have a minimum length" do
  	@user.mobileno = "a" * 6
  	assert_not @user.valid?
  end
  test "mobileno should have a maximum length" do
  	@user.mobileno = "a" * 13
  	assert_not @user.valid?
  end
  test "classten should not be too long" do
  	@user.classten = "a" * 6
  	assert_not @user.valid?
  end
  test "classtwelve should not be too long" do
  	@user.classtwelve = "a" * 6
  	assert_not @user.valid?
  end
  test "achievements should not be too long" do
  	@user.achievements = "a" * 501
  	assert_not @user.valid?
  end
  test "experience should not be too long" do
  	@user.experience = "a" * 501
  	assert_not @user.valid?
  end
  test "projects should not be too long" do
  	@user.projects = "a" * 301
  	assert_not @user.valid?
  end
  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
end
