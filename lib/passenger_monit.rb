module PassengerMonit
  
  mattr_accessor :pid_dir
  @@pid_dir = '/var/tmp'
  
  mattr_accessor :pid_file
  @@pid_file = 'rack.*.pid'
  
  class Railtie < Rails::Railtie
    config.before_initialize do
      if defined?(PhusionPassenger)
        require 'passenger_monit/pidfile_manager'
        PhusionPassenger.on_event(:starting_worker_process) do |forked|
          PidfileManager.write_pid_file if forked
        end

        PhusionPassenger.on_event(:stopping_worker_process) do
          PidfileManager.remove_pid_file
        end
      end
    end
  end
  
  def self.setup
    yield self
  end
end
