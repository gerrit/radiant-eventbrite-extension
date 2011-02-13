begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = 'radiant-eventbrite-extension'
    gem.summary = 'Eventbrite Extension for Radiant CMS'
    gem.description = 'Provides a few Radius Tags to access data from the EventBrite API'
    gem.email = 'gerrit@gerritkaiser.de'
    gem.homepage = 'http://ext.radiantcms.org/extensions/265-eventbrite'
    gem.authors = ['Gerrit Kaiser']
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. This is only required if you plan to package eventbrite as a gem."
end

# In rails 1.2, plugins aren't available in the path until they're loaded.
# Check to see if the rspec plugin is installed first and require
# it if it is.  If not, use the gem version.

# Determine where the RSpec plugin is by loading the boot
unless defined? RADIANT_ROOT
  ENV["RAILS_ENV"] = "test"
  case
  when ENV["RADIANT_ENV_FILE"]
    require File.dirname(ENV["RADIANT_ENV_FILE"]) + "/boot"
  when File.dirname(__FILE__) =~ %r{vendor/radiant/vendor/extensions}
    require "#{File.expand_path(File.dirname(__FILE__) + "/../../../../../")}/config/boot"
  else
    require "#{File.expand_path(File.dirname(__FILE__) + "/../../../")}/config/boot"
  end
end

require 'rake'
require 'rake/rdoctask'

desc 'Generate documentation for the eventbrite extension.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'EventbriteExtension'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

# Load any custom rakefiles for extension
Dir[File.dirname(__FILE__) + '/tasks/*.rake'].sort.each { |f| require f }