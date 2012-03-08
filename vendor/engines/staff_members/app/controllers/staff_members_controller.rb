class StaffMembersController < ApplicationController

  before_filter :find_all_staff_members
  before_filter :find_page

  def index
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @staff_member in the line below:
    present(@page)
  end

  def show
    @staff_member = StaffMember.find(params[:id])

    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @staff_member in the line below:
    present(@page)
  end

  def administration
    @administration = true
    @staff_members = find_all_administrators 

    present(@page)
    render :template => 'staff_members/index'
  end

  def teachers
    @teachers = true
    @staff_members = find_all_teachers

    if grade = params[:grade]
      @staff_members = @staff_members.where(:grade => grade)
    end

    @grades = StaffMember::GRADES

    present(@page)
    render :template => 'staff_members/index'
  end

protected

  def page
    params[:page] || 1
  end

  def find_all_administrators
    @all ||= find_all_staff_members.where(:staff_type => StaffMember::StaffTypes::ADMINISTRATION)
  end

  def find_all_teachers
    find_all_staff_members.where(:staff_type => StaffMember::StaffTypes::TEACHER)
  end

  def find_all_staff_members
    @staff_members = StaffMember.paginate(:page => page, :per_page => 5).order('last_name ASC')
  end

  def find_page
    @page = Page.where(:link_url => "/staff_members").first
  end

end
