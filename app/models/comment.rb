class Comment < ActiveRecord::Base
  validates_presence_of :authors_name, :body#, :post_id
  belongs_to :post, :touch => true
end

