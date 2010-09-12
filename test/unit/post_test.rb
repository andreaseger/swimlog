require 'test_helper'

class PostTest < ActiveSupport::TestCase

  test "should not save post w/o title" do
    _post =  Post.new
    assert !_post.save, "saving w/o title possible"

    _post = Post.new(:title => "Foobar")
    assert _post.save, "saving w title not possible"
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

