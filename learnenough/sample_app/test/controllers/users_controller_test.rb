require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:archer)
    @otheruser = users(:lana)
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end


  test "should redirect EDIT when not logged in" do
    log_in_as(@otheruser)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect UPDATE when not logged in" do
    log_in_as(@otheruser)
    patch user_path(@user), params: { user: { name: @user.name, email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@otheruser)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

=begin   test "should redirect SHOW when not logged in" do
    log_in_as(@otheruser)
    get user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end 
=end

  test "should get new" do
    get signup_path
    assert_response :success
  end

end
