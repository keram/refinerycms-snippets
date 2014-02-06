plugin = Refinery::Plugins['snippets']

if plugin && defined?(Refinery::User)
  Refinery::User.all.each do |user|
    if user.plugins.find_by(name: plugin.name).nil?
      user.plugins.create(name: plugin.name,
                          position: (user.plugins.maximum(:position) || -1) +1)
    end
  end


  Refinery::Snippet.create(title: 'test snippet', body: 'lorem ipsum')
  Refinery::Snippet.create(title: 'second snippet', body: 'lorem <b>ipsum</b>athz')
end
