module Admin
  class SlidesController < Admin::BaseController

    crudify :slide,
            :title_attribute => 'text', :xhr_paging => true

  end
end
