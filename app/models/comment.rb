class Comment < ActiveRecord::Base
  validates_presence_of :authors_name, :body
  belongs_to :post
end

