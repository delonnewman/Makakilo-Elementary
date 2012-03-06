class Link < ActiveRecord::Base
  TYPES  = %w{ kids parents }
  LABELS = {
    TYPES[0] => 'Links for Kids',
    TYPES[1] => 'Links for Parents',
  }

  module LinkTypes
    KIDS    = TYPES[0].freeze
    PARENTS = TYPES[1].freeze
  end


  acts_as_indexed :fields => [:title, :url]

  validates :title, :presence => true, :uniqueness => true
  validates :link_type, :presence => true
  validates :link_type, :inclusion => { :in => TYPES }
end
