class Post < ActiveRecord::Base
  validates_presence_of :title
  has_many :comments, :dependent => :destroy
  has_many :items, :dependent => :destroy

  accepts_nested_attributes_for :items , :reject_if => lambda { |a| a[:text].blank? }, :allow_destroy => true
end

