require 'rake'
require 'rake/rdoctask'

desc 'Default: create gemspec'
task :default => :gemspec

desc 'Generate documentation for the passenger_monit plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'PassengerMonit'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "passenger_monit"
    gem.summary = %Q{Support for monitoring Passenger with Monit}
    gem.description = gem.summary
    gem.email = "romanbsd@yahoo.com"
    gem.homepage = "http://github.com/romanbsd/passenger_monit"
    gem.authors = ["Roman Shterenzon"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
end
