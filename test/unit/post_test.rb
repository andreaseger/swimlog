require 'test_helper'

class PostTest < ActiveSupport::TestCase

  test "should not save post without title" do
    _post =  Post.new
    assert !_post.save
  end

  test "should save post with title" do
    _post = Post.new(:title => "Foobar")
    assert _post.save
  end

end

