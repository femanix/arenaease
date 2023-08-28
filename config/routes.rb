require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'comandas#index'
  resources :team_accounts
  resources :teams
  resources :invoices
  devise_for :users
  resources :suppliers
  resources :cash_outs
  resources :cash_ins
  resources :users, as: 'users'
  resources :itens_comandas
  resources :alunos
  resources :matriculas
  resources :modalidades
  resources :planos
  resources :comandas
  resources :forma_pagamentos
  resources :clientes
  resources :estoque_ins
  resources :estoque_outs
  namespace :produtos do
    get 'search', to: 'search'
  end
  resources :produtos
  resources :mensalidades

  authenticate :user, ->(user) { user.super_admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # Comandas

  get 'comandas/:id/emitir_nf', to: 'comandas#emitir_nf', as: 'comanda_emitirnf'
  get 'comandas/:id/encerrar/', to: 'comandas#encerrar', as: 'encerrar_comanda'
  get 'comandas/:id/imprimir/', to: 'comandas#imprimir', as: 'imprimir_comanda'
  get 'comandas/:id/pagar/', to: 'comandas#pagar', as: 'pagar_comanda'
  post 'comandas/balcao/', to: 'comandas#balcao', as: 'comanda_balcao'

  # Mensalidades

  get 'mensalidade/:id/cancelar/', to: 'mensalidades#cancelar', as: 'cancelar_mensalidade'
  get 'mensalidade/:id/recibo/', to: 'mensalidades#recibo', as: 'recibo_mensalidade'
  get 'mensalidade/:id/rematricular/', to: 'mensalidades#rematricular', as: 'rematricular_aluno'
  get 'recibo/:token/', to: 'recibos#show', as: 'recibo'
  get 'mensalidade/:id/pagar', to: 'mensalidades#pagar', as: 'pagar_mensalidade_form'
  post 'mensalidade/:id/pagar', to: 'mensalidades#pagar', as: 'pagar_mensalidade'
  get 'mensalidade/:id/estornar', to: 'mensalidades#estornar', as: 'estornar_mensalidade'

  # Chute Inicial

  get 'alunos/:id/matricular', to: 'alunos#matricular', as: 'matricular_aluno'
  get 'alunos/:id/contrato', to: 'alunos#contrato', as: 'gerar_contrato'
  get 'modalidade/:m/aluno/new', to: 'alunos#new', as: 'novo_aluno_chute_inicial'

  # Aluguel de Quadra

  get 'teams/:id/contratar', to: 'teams#contratar', as: 'contratar'
  post 'teams/:id/contratar', to: 'teams#contratar', as: 'contratar_quadra'
  get 'teams/:id/inativar', to: 'teams#inativar', as: 'inativar_team'
  get 'team_accounts/:id/pagar', to: 'team_accounts#pagar_aluguel', as: 'pagar_aluguel_form'
  post 'team_accounts/:id/pagar', to: 'team_accounts#pagar_aluguel', as: 'pagar_aluguel'

  # Beach Volley

  get 'modalidade/:m/alunos', to: 'alunos#index', as: 'alunos_list'
  get 'modalidade/:m/mensalidades', to: 'mensalidades#index', as: 'mensalidades_list'
  get 'modalidade/:m/mensalidades/:id', to: 'mensalidades#show', as: 'mensalidades_aluno_list'


  # Páginas de erro

  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_server_error'
  get '/402', to: 'errors#unprocessable_entity'
end
