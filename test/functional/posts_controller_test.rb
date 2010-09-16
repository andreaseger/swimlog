require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @hubert = User.create!(:username => "hubert",  :roles_mask=>1, :password =>'foobar', :email=>'foo@bar.com') #admin
    @post = Post.create!(:user => @hubert, :title => "Lorem", "items_attributes" => {"0"=>{"level"=>"0", "text"=>"lorem"}, "1"=>{"level"=>"4", "text"=>"ipsum"}})
    @hpost = {"user" => @hubert, "title" => "Lorem", "items_attributes" => {"0"=>{"level"=>"0", "text"=>"lorem"}, "1"=>{"level"=>"4", "text"=>"ipsum"}}}
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    sign_in @hubert
    get :new
    assert_response :success
  end

  test "should create post" do
    sign_in @hubert
    assert_difference('Post.count') do
      post :create, :post => @hpost
    end

    assert_redirected_to post_path(assigns(:post))
  end

  test "should show post" do
    get :show, :id => @post.to_param
    assert_response :success
  end

  test "should get edit" do
    sign_in @hubert
    get :edit, :id => @post.to_param
    assert_response :success
  end

  test "should update post" do
    sign_in @hubert
    put :update, :id => @post.to_param, :post => @hpost
    assert_redirected_to post_path(assigns(:post))
  end

  test "should destroy post" do
    sign_in @hubert
    assert_difference('Post.count', -1) do
      delete :destroy, :id => @post.to_param
    end

    assert_redirected_to posts_path
  end

  test "should generate schedule listing" do
    sign_in @hubert
    @hpost = {"user" => @hubert, "title" => "Lorem"}
    items = {"items_attributes" => {"0" =>{"level" => "0", "text"=> "foo"}, "1" =>{"level" => "1", "text"=> "bar"}, "2" =>{"level" => "2", "text"=> "baz"} }}
    assert_difference('Post.count') do
      post :create, :post => @hpost.merge(items)
    end
    @saved = assigns(:post)
    assert_equal "p(level-0). foo\n\np(level-1). bar\n\np(level-2). baz\n\n",@saved.schedule
  end
end

