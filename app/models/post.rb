class Post < ActiveRecord::Base
  validates_presence_of :title
  has_many :comments, :dependent => :destroy
  has_many :items, :dependent => :destroy

  accepts_nested_attributes_for :items , :reject_if => lambda { |a| a[:text].blank? }, :allow_destroy => true


  def generate_schedule
    schedule = ""
    items.each do |item|
      item.level.times {schedule << "--"}
      schedule << item.text << "\n"
    end
    self.schedule = schedule
  end

  def generate_schedule_hash(items)
    schedule = ""
    items.each do |item|
      (item[1][:level].to_i).times {schedule << "--"}
      schedule << item[1][:text] << "\n"
    end
    schedule
  end
end

