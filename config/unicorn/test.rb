root = "/var/www/test.urupaarena/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"
worker_processes 4
timeout 30
preload_app true
listen '/tmp/test.urupaarena.sock', backlog: 64

ENV['RAILS_ENV'] ||= 'test'