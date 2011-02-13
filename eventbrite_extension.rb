class EventbriteExtension < Radiant::Extension
  version File.read(File.join(File.dirname(__FILE__), 'VERSION'))
  description 'Provides a few Radius Tags to access data from the EventBrite API'
  url "http://ext.radiantcms.org/extensions/265-eventbrite"
  
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
