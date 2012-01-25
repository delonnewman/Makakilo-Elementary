class SlidesController < ApplicationController

  before_filter :find_all_slides
  before_filter :find_page

  def index
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @slide in the line below:
    present(@page)
  end

  def show
    @slide = Slide.find(params[:id])

    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @slide in the line below:
    present(@page)
  end

protected

  def find_all_slides
    @slides = Slide.order('position ASC')
  end

  def find_page
    @page = Page.where(:link_url => "/slides").first
  end

end
