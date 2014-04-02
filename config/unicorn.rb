worker_processes 4
timeout 15
preload_app true

stderr_path "/var/www/chipotle/current/log/unicorn.log"
stdout_path "/var/www/chipotle/current/log/unicorn.log"

# Unicorn socket
listen "/tmp/unicorn.chi-cds.sock"

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end