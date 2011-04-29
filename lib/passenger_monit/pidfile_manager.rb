module PassengerMonit::PidfileManager
  extend self
  
  BASENAME = '/var/tmp/rack.*.pid'
  
  def write_pid_file
    pid = Process.pid
    count = 1
    pidfile = nil
    go_over_pid_files do |file, saved_pid|
      file_id = file[/(\d+)/,1].to_i
      # Increase counter only if we met the same file id
      count += 1 if file_id == count
      # We're already there
      return if saved_pid == pid
      # Check if the process is alive
      res = begin
        Process.kill(0, saved_pid)
      rescue Errno::ESRCH
        nil
      end
      # It's dead, reuse
      unless res
        pidfile = file
        break
      end
    end
    pidfile ||= BASENAME.sub('*', count.to_s)
    File.open(pidfile, 'w') {|f| f.write(pid.to_s)}
  end
  
  def remove_pid_file
    pid = Process.pid
    go_over_pid_files do |file, saved_pid|
      if pid == saved_pid
        File.unlink(file)
        break
      end
    end
  end
  
  private
  def go_over_pid_files
    Dir[BASENAME].each do |file|
      saved_pid = File.read(file).to_i
      yield file, saved_pid
    end
  end

end
