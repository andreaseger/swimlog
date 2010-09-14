require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = posts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post :create, :post => @post.attributes
    end

    assert_redirected_to post_path(assigns(:post))
  end

  test "should show post" do
    get :show, :id => @post.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @post.to_param
    assert_response :success
  end

  test "should update post" do
    put :update, :id => @post.to_param, :post => @post.attributes
    assert_redirected_to post_path(assigns(:post))
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete :destroy, :id => @post.to_param
    end

    assert_redirected_to posts_path
  end

  test "should generate schedule listing" do
    @post = posts(:three)
    items = {"items_attributes" => {"0" =>{"level" => "0", "text"=> "foo"}, "1" =>{"level" => "1", "text"=> "bar"}, "2" =>{"level" => "2", "text"=> "baz"} }}
    assert_difference('Post.count') do
      post :create, :post => @post.attributes.merge(items)
    end
    @saved = assigns(:post)
    assert_equal "p(level-0). foo\n\np(level-1). bar\n\np(level-2). baz\n\n",@saved.schedule
  end
end

