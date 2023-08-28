require 'faker'
require 'cpf_cnpj'
namespace :dev do
  DEFAULT_PASS = 123456
  DEFAULT_METHODS =
                    [
                      'Dinheiro',
                      'Cartão de Crédito',
                      'Cartão de Débito',
                      'PIX'
                    ]

  desc 'TODO'
  task setup: :environment do
    unless Rails.env.production?
      spinner('Apagando banco de Dados...') { `rails db:drop` }
      spinner('Criando banco de Dados...') { `rails db:create` }
      spinner('Migrando banco de Dados...') { `rails db:migrate` }
      spinner('Cadastrando Planos e modalidades...') { `rails dev:add_plans` }
    end
    # else
    #   puts "Você não está em ambiente de Desenvolvimento"
    # end
    spinner('Cadastrando Administrador Padrão...') { `rails dev:add_default_admin` }
    spinner('Cadastrando Cliente Test...') { `rails dev:add_default_client` }
    spinner('Cadastrando Formas de Pagamento...') { `rails dev:add_methods` }
  end

  desc 'Adiciona o administrador padrão'
  task add_default_admin: :environment do
    User.create!(
      email: 'lucas@superadmin.dev',
      password: DEFAULT_PASS,
      password_confirmation: DEFAULT_PASS,
      first_name: 'Super',
      last_name: 'Admin',
      super_admin: true
    )
  end

  desc 'Adiciona o cliente padrão'
  task add_default_client: :environment do
    Cliente.create!(
      nome_cliente: 'Cliente Teste',
      telefone: '11971316487',
      cpf: '45025474163'
    )
  end

  desc 'Adiciona Formas de Pagamento'
  task add_methods: :environment do
    DEFAULT_METHODS.each do |method|
      FormaPagamento.create!(
        descricao: method
      )
    end
  end

  desc 'Adiciona produto padrão'
  task add_products: :environment do
    Produto.create!(
      descricao: 'Coxinha - (Produto Teste)',
      categoria: 3,
      preco_compra: 8.00,
      preco_venda: 10.00,
      ncm: 7_894_900_011_517,
      quantidade_minima: 1,
      itens_cx: 12,
      data_validade: Date.today
    )
    Produto.create!(
      descricao: 'Suco de Uva - (Produto Teste)',
      categoria: 1,
      preco_compra: 4.00,
      preco_venda: 7.00,
      ncm: 7_894_900_011_517,
      quantidade_minima: 1,
      itens_cx: 12,
      data_validade: Date.today
    )
  end

  desc 'Adiciona Modalidade e Plano Test'
  task add_plans: :environment do
    Modalidade.create!(descricao: 'Modalidade Teste')
    Plano.create!(
      modalidade_id: 1,
      descricao: 'Plano Test',
      valor: 100.00
    )
  end

  desc 'Adiciona 25 alunos'
  task add_25_alunos: :environment do
    25.times do
      Aluno.create!(
        nome: Faker::Name.name,
        data_nascimento: rand(-365..365).years.from_now.to_date,
        cpf: CPF.generate,
        cep: '05574310',
        numero: rand(1..666),
        telefone1: Faker::PhoneNumber.cell_phone.gsub(/\D/, ''),
        telefone2: Faker::PhoneNumber.cell_phone.gsub(/\D/, ''),
        responsavel1: Faker::Name.name,
        modalidade_id: 1
      )
    end
  end

  private

  def spinner(msg_start, msg_end = 'Concluído com sucesso!')
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}", format: :spin)
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
