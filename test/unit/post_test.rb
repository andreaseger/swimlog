require 'test_helper'

class PostTest < ActiveSupport::TestCase

  test "should not save post w/o title" do
    _post =  Post.new
    assert !_post.save "saving w/o title possible"

    _post = Post.new(:title => "Foobar")
    assert _post.save "saving w title not possible"
  end
end
