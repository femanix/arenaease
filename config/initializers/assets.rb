# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )

Rails.application.config.assets.precompile += %w[ sistema.coffee cash_outs.scss comandas.js cash_ins.scss cash_ins.js
                                                  sistema.scss comandas.scss produtos.scss produtos.js clientes.js
                                                  imprimir.scss alunos.js planos.js cash_outs.js cash_outs.scss
                                                  alunos.scss teams.scss teams.js teams_accounts.scss planos.scss
                                                  mensalidades.scss recibos.scss errors.scss errors.js team_accounts.js mensalidades.js]

Rails.application.config.assets.precompile += %w[logo_chute_inicial.png]
