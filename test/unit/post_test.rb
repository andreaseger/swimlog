require 'test_helper'

class PostTest < ActiveSupport::TestCase
  setup do
    @hubert = User.create!(:username => "hubert",  :roles_mask=>1, :password =>'foobar', :email=>'foo@bar.com') #admin
    @anne = User.create!(:username => "anne",  :password =>'foobar', :email=>'foo@baar.com')     #user
  end

  test "should not save post w/o title or items" do
    _post =  Post.new(:user => @hubert)
    assert !_post.save, "saving w/o title & items possible"

    _post = Post.new(:user => @hubert, :title => "Foobar")
    assert !_post.save, "saving w/o items possible"
  end

  test "should save post w/ title and items" do
    _post = Post.new(:user => @hubert, :title => "Lorem", "items_attributes" => {"0"=>{"level"=>"0", "text"=>"lorem"}, "1"=>{"level"=>"4", "text"=>"ipsum"}})
    assert _post.save, "saving w title and items not possible"
  end

  test "should not be able to create, update, destroy post as user" do
    ability = Ability.new(@anne)
    assert ability.cannot?(:create, Post.new)
    assert ability.cannot?(:destroy, Post.new)
    assert ability.cannot?(:update, Post.new)
  end

  test "should be able to create, update, destroy post as admin" do
    ability = Ability.new(@hubert)
    assert ability.can?(:create, Post.new)
    assert ability.can?(:destroy, Post.new)
    assert ability.can?(:update, Post.new)
  end

  test "should destroy comments after destroying the post" do
    assert_difference("Comment.count", 2) do
      @post = posts(:two)
      Comment.create!(:authors_name => "hubert", :body => "Yea great schedule", :post_id => @post.id)
      Comment.create!(:authors_name => "bernd", :body => "Yea great schedule", :post_id => @post.id)
    end

    assert_equal 2, @post.comments.count, "There are not 2 Comments for this post"

    assert_difference("Comment.count", -2) do
      @post.destroy
    end
  end

  test "should destroy items after destroying the post" do
    assert_difference("Item.count", 2) do
      @post = posts(:two)
      Item.create!(:level => 3, :text => "300m Kraul", :post_id => @post.id)
      Item.create!(:level => 7, :text => "200m Dephin", :post_id => @post.id)
    end

    assert_equal 2, @post.items.count, "There are not 2 Items for this post"

    assert_difference("Item.count", -2) do
      @post.destroy
    end
  end


end

