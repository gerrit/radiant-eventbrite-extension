module EventbriteTags
  include Radiant::Taggable
  class TagError < StandardError; end
  
  desc %{
    Set a user for the Eventbrite API.
    
    Needs an attribute @user@ witha a valid Eventbrite API User Key
    Obtain yours at http://www.eventbrite.com/userkeyapi
  }
  tag 'eventbrite' do |tag|
    user_attr_msg = 'r:eventbrite tag must contain a “user” attribute with a Eventbrite API User Key.'
    raise TagError.new(user_attr_msg) unless tag.attr.has_key?('user')
    EventBright.setup(EventbriteExtension.api_key)
    tag.locals.eventbrite_user = EventBright::User.new(tag.attr['user'])
    tag.expand
  end
  
  # namespace
  tag 'eventbrite:events' do |tag|
    tag.expand
  end
  
  desc %{
    Iterates over a user's events
    
    Defaults to showing only “live” events
    (i.e. active and public ones that are in the future).
    This can be overriden by using the @status@ attribute to one of
    “draft”, “live”, “started”, “ended”, or “canceled”.
  }
  tag 'eventbrite:events:each' do |tag|
    requested_status = (tag.attr['status'] || 'live')
    tag.locals.eventbrite_user.events.collect do |event|
      if event.status.downcase == requested_status
        tag.locals.eventbrite_event = event
        tag.expand
      end
    end
  end
  
  %w[start_date end_date created modified].each do |date_attr|
    desc %{
      Renders the #{date_attr} Time/Date of the current event
      
      Accepts an optional @format@ attribute (see documentation for r:date tag)
    }
    tag "eventbrite:events:each:#{date_attr}" do |tag|
      format = (tag.attr['format'] || '%A, %B %d, %Y')
      time = tag.locals.eventbrite_event.attributes[date_attr.to_sym]
      time.strftime(format)
    end
  end
  
  %w[
    title description category tags timezone
    capacity url logo logo_ssl status
  ].each do |attribute|
    desc %{
      Renders the #{attribute} of the current event
      
      (see http://developer.eventbrite.com/doc/users/user_list_events/)
    }
    tag "eventbrite:events:each:#{attribute}" do |tag|
      tag.locals.eventbrite_event.send attribute
    end
  end
  
end
