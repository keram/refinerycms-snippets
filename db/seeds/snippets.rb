Refinery::User.find(:all).each do |user|
  if user.plugins.where(:name => 'snippets').blank?
    user.plugins.create(:name => 'snippets',
                        :position => (user.plugins.maximum(:position) || -1) +1)
  end
end if defined?(Refinery::User)