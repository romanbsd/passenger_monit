module PassengerMonit
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
end
