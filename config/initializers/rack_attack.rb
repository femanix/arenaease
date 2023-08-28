Rack::Attack.blocklist('allow2ban pentesters') do |req|
  Rack::Attack::Allow2Ban.filter(req.ip, maxretry: 15, findtime: 1.minutes, bantime: 3.days) do
    req.path == '/users/sign_in' and req.get?
  end
end

# config/initializers/rack_attack.rb (for rails apps)

Rack::Attack.blocklist_ip('159.203.82.126')
Rack::Attack.throttle('req/ip', limit: 5, period: 2) do |req|
  req.ip
end

# Configuração do logger
log_file = File.join(Rails.root, 'log', "#{ENV['RAILS_ENV']}.log")
logger = Logger.new(log_file)

Rack::Attack.blocklisted_responder = lambda do |_env|
  message = 'Seu IP foi bloqueado!'
  # Use o logger para escrever a mensagem de erro personalizada no arquivo de log
  logger.error(message)

  [401, { 'Content-Type' => 'application/json' }, [message]]
end

Rack::Attack.blocklist('allow2ban bad request') do |req|
  Rack::Attack::Allow2Ban.filter(req.ip, maxretry: 5, findtime: 1.minute, bantime: 1.year) do
    req.env['rack.request.form_hash'].nil? && req.env['HTTP_REFERER'].nil? && req.env['HTTP_USER_AGENT'] != 'whitelisted user agent'
  end
end
