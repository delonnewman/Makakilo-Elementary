module NavigationHelpers
  module Refinery
    module Slides
      def path_to(page_name)
        case page_name
        when /the list of slides/
          admin_slides_path

         when /the new slide form/
          new_admin_slide_path
        else
          nil
        end
      end
    end
  end
end
