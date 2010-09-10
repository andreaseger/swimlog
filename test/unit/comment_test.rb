require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "should not save comment w/o author or body" do
    comment =  Comment.new
    assert !comment.save

    comment = Comment.new(:authors_name => "hubert")
    assert !comment.save

    comment = Comment.new(:body => "Yea great schedule")
    assert !comment.save

    comment = Comment.new(:authors_name => "hubert", :body => "Yea great schedule")
    assert comment.save

  end
end

