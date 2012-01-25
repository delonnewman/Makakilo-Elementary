class Slide < ActiveRecord::Base

  acts_as_indexed :fields => [:text]

  validates :text, :presence => true, :uniqueness => true
  
  belongs_to :photo, :class_name => 'Image'
end
