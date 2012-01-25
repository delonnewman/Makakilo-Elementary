if defined?(User)
  User.all.each do |user|
    if user.plugins.where(:name => 'slides').blank?
      user.plugins.create(:name => 'slides',
                          :position => (user.plugins.maximum(:position) || -1) +1)
    end
  end
end

if defined?(Page)
  page = Page.create(
    :title => 'Slides',
    :deletable => false,
    :show_in_menu => false,
  )
  Page.default_parts.each do |default_page_part|
    page.parts.create(:title => default_page_part, :body => nil)
  end
end
