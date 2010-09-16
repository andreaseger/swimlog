require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @comment = comments(:one)
    @anne = User.create!(:username => "anne", :password =>'foobar', :email=>'foo@bar.com') #user
    @hubert = User.create!(:username => "hubert",  :roles_mask=>1, :password =>'foobar', :email=>'foo@baar.com') #admin
  end

  test "should create comment" do
    sign_in @anne
    assert_difference('Comment.count') do
      post :create, :comment => @comment.attributes
    end

    #redirect to the posts path
    assert_redirected_to post_path(assigns(:comment)[:post_id])
  end

#  test "should get edit" do
#    get :edit, :id => @comment.to_param
#    assert_response :success
#  end

#  test "should update comment" do
#    put :update, :id => @comment.to_param, :comment => @comment.attributes
#    assert_redirected_to comment_path(assigns(:comment))
#  end

  test "should destroy comment as admin" do
    sign_in @hubert
    assert_difference('Comment.count', -1) do
      delete :destroy, :id => @comment.to_param
    end

    assert_redirected_to post_path(@comment.post)
  end

  test "should not destroy comment as user" do
    sign_in @anne
    assert_difference('Comment.count', 0) do
      delete :destroy, :id => @comment.to_param
    end
  end
end

