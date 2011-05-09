User.all.each do |user|
  if user.plugins.where(:name => 'snippets').blank?
    user.plugins.create(:name => 'snippets',
                        :position => (user.plugins.maximum(:position) || -1) +1)
  end
end

# we don't need this on frontend
#page = Page.create(
#  :title => 'Snippets',
#  :link_url => '/snippets',
#  :show_in_menu => false,
#  :deletable => false,
#  :position => ((Page.maximum(:position, :conditions => {:parent_id => nil}) || -1)+1),
#  :menu_match => '^/snippets(\/|\/.+?|)$'
#)
#
#Page.default_parts.each do |default_page_part|
#  page.parts.create(:title => default_page_part, :body => nil)
#end
