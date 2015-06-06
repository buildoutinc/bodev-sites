# This singleton class act as an temp storage for the
# current site and domain
class SiteFramework::CurrentState
  include Singleton

  attr_accessor :site, :domain, :domain_name
end
