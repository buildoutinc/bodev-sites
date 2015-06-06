class SiteFramework::Routing::SiteConstraint

  attr_reader :logger

  def initialize
    @logger = Rails.logger
  end

  def domain(name)
    @domain ||= if defined? ActiveRecord
      SiteFramework::Domain.find_by(name: name)
    elsif defined? Mongoid
      SiteFramework::Site.where('domains.name' => name).domains.first
    else
      nil
    end

  end

  def matches?(request)
    @domain_name = request.host

    if domain_obj = domain(request.host)
      logger.debug("''#{@domain_name}' matched.")
      setup(domain_obj)
      initialize_site_default_state
      true
    else
      logger.info("Domain name '#{request.host}' does not match with any exist domains")
      false
    end
  end

  private

  def setup(domain)
    SiteFramework::CurrentState.instance.domain_name = domain.name
    SiteFramework::CurrentState.instance.domain      = domain
    SiteFramework::CurrentState.instance.site        = domain.site
    @site                                            = domain.site
  end

  def initialize_site_default_state
    @site.try(:before_dispatch)
  end
end
