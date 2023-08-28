role :app, %w{deploy@146.190.210.43}
role :web, %w{deploy@146.190.210.43}
role :db, %w{deploy@146.190.210.43}

set :deploy_to, '/var/www/test.arenaease'

set :ssh_options, {
  user: 'deploy',
  keys: %w(~/.ssh/id_rsa),
  forward_agent: true,
  auth_methods: %w(publickey)
}

set :rails_env, 'test'