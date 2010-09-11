require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "should not save comment w/o author or body" do
    comment =  Comment.new
    assert !comment.save "saving w/o parameter possible"

    comment = Comment.new(:authors_name => "hubert")
    assert !comment.save "saving w/o body possible"

    comment = Comment.new(:body => "Yea great schedule")
    assert !comment.save "saving w/o name possible"

    comment = Comment.new(:authors_name => "hubert", :body => "Yea great schedule")
    assert comment.save "saving w/ all parameter not possible"
  end

end

