class EventbriteExtension < Radiant::Extension
  version '0.1'
  description 'Provides a few Radius Tags to access data from the EventBrite API'
  url "http://github.com/gerrit/radiant-eventbrite-extension"
  
  extension_config do |config|
    config.gem 'eventbright'
  end
  
  # Registered for use with this extension
  # May be rate-limited at some point
  API_KEY = 'MzUxOTYzYTRkNzEy'
  
  def self.api_key
    Radiant::Config['eventbrite.api_key'] || API_KEY
  end
  
  def activate
    Page.send :include, EventbriteTags
  end
end