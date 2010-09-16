require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  setup do
    @post = posts(:one)
  end

  test "should not save comment w/o post_id or body" do
    comment =  Comment.new
    assert !comment.save, "saving w/o parameter possible"

    comment = Comment.new(:body => "Yea great schedule")
    assert !comment.save, "saving w/o name,post_id possible"

    comment = Comment.new(:post_id => @post.id)
    assert !comment.save, "saving w/o body possible"

    comment = Comment.new(:body => "Yea great schedule", :post_id => @post.id)
    assert comment.save, "saving w/ all parameter not possible"
  end

end

