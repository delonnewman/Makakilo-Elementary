class StaffMember < ActiveRecord::Base
  GRADES      = %w{ SPED K 1 2 3 4 5 }
  STAFF_TYPES = %w{ Administration Teacher }

  module StaffTypes
    ADMINISTRATION = STAFF_TYPES[0].freeze
    TEACHER        = STAFF_TYPES[1].freeze
  end

  acts_as_indexed :fields => [:name, :email]

  validates :last_name, :presence => true, :uniqueness => { :scope => :first_name }
  validates :staff_type, :presence => true
  validates :staff_type, :inclusion => { :in => STAFF_TYPES }
  validates :grade, :presence => true, :if => :teacher?
  
  belongs_to :photo, :class_name => 'Image'

  def teacher?
    staff_type == StaffTypes::TEACHER
  end

  def name
    "#{first_name} #{last_name}"
  end
end
