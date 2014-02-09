module Refinery
  module Snippets
    include ActiveSupport::Configurable

    config_accessor :activate_by_default

    self.activate_by_default = {}
  end
end
