Refinery::User.find(:all).each do |user|
  if user.plugins.where(:name => 'refinery_snippets').blank?
    user.plugins.create(:name => 'refinery_snippets',
                        :position => (user.plugins.maximum(:position) || -1) +1)
  end
end if defined?(Refinery::User)