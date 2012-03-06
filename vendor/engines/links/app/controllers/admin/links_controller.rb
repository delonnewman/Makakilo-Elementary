module Admin
  class LinksController < Admin::BaseController
    before_filter :get_link_types

    crudify :link, :xhr_paging => true

    def get_link_types
      @link_types = Link::TYPES
    end
  end
end
