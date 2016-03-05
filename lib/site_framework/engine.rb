module SiteFramework
  # **SiteFramework** rails engine class.
  class Engine < ::Rails::Engine

    isolate_namespace SiteFramework
    engine_name 'site_framework'

    config.generators do |g|
      g.test_framework :rspec
    end

    @@default_domains = ['localhost']
    mattr_accessor :default_domains

    # This option allows developers to specify the prefix of path
    # which they wanted to prepend to view_paths array
    mattr_accessor :view_path_prefix
    @@view_path_prefix = "app/views"

    def self.setup
      yield self
    end
  end
end
