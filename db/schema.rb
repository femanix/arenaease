# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_08_17_191023) do

  create_table "alunos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "nome"
    t.date "data_nascimento"
    t.integer "rg"
    t.bigint "cpf"
    t.integer "numero"
    t.bigint "telefone1"
    t.bigint "telefone2"
    t.bigint "telefone3"
    t.text "responsavel1"
    t.text "responsavel2"
    t.bigint "modalidade_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["modalidade_id"], name: "index_alunos_on_modalidade_id"
  end

  create_table "cash_ins", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "description"
    t.string "origin", default: "Receita Avulsa"
    t.integer "value_cents", default: 0, null: false
    t.integer "method"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "mensalidade_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_cash_ins_on_deleted_at"
    t.index ["mensalidade_id"], name: "index_cash_ins_on_mensalidade_id"
  end

  create_table "cash_outs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "description"
    t.string "category"
    t.decimal "value_cents", precision: 10, default: "0", null: false
    t.string "method"
    t.date "expiration"
    t.date "payment_date"
    t.string "supplier"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_cash_outs_on_deleted_at"
  end

  create_table "clientes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "nome_cliente"
    t.text "telefone"
    t.bigint "cpf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comandas", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "itens_comanda_id"
    t.bigint "cliente_id"
    t.integer "valor_total_cents", default: 0, null: false
    t.integer "status", default: 0
    t.text "observacao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_comandas_on_cliente_id"
    t.index ["itens_comanda_id"], name: "index_comandas_on_itens_comanda_id"
  end

  create_table "enderecos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "aluno_id", null: false
    t.string "rua"
    t.integer "numero"
    t.string "bairro"
    t.string "cidade"
    t.string "estado"
    t.string "cep"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["aluno_id"], name: "index_enderecos_on_aluno_id"
  end

  create_table "estoque_ins", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "produto_id"
    t.integer "quantidade"
    t.integer "preco_compra_cents", default: 0, null: false
    t.bigint "user_id"
    t.bigint "supplier_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["produto_id"], name: "index_estoque_ins_on_produto_id"
    t.index ["supplier_id"], name: "index_estoque_ins_on_supplier_id"
    t.index ["user_id"], name: "index_estoque_ins_on_user_id"
  end

  create_table "estoque_outs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "produto_id"
    t.integer "quantidade"
    t.bigint "user_id"
    t.string "origem"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["produto_id"], name: "index_estoque_outs_on_produto_id"
    t.index ["user_id"], name: "index_estoque_outs_on_user_id"
  end

  create_table "forma_pagamentos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "comanda_id", null: false
    t.string "nota_chave"
    t.string "nota_numero"
    t.integer "valor_cents", default: 0, null: false
    t.string "nota_status"
    t.string "nota_situacao"
    t.string "nota_pdf"
    t.string "nota_xml"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["comanda_id"], name: "index_invoices_on_comanda_id"
  end

  create_table "itens_comandas", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "comanda_id"
    t.bigint "produto_id"
    t.integer "quantidade"
    t.integer "valor_cents", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comanda_id"], name: "index_itens_comandas_on_comanda_id"
    t.index ["produto_id"], name: "index_itens_comandas_on_produto_id"
  end

  create_table "matriculas", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "data_matricula"
    t.date "validade_exame"
    t.date "renovacao"
    t.decimal "desconto", precision: 5, scale: 2
    t.bigint "plano_id", null: false
    t.bigint "aluno_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "class_schedule"
    t.integer "status", default: 0
    t.index ["aluno_id"], name: "index_matriculas_on_aluno_id"
    t.index ["plano_id"], name: "index_matriculas_on_plano_id"
  end

  create_table "mensalidades", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "aluno_id"
    t.date "vencimento"
    t.integer "value_cents", default: 0, null: false
    t.bigint "plano_id", null: false
    t.integer "status", default: 0
    t.date "data_pagamento"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "valor_pago_cents", default: 0
    t.bigint "team_id"
    t.datetime "deleted_at"
    t.index ["aluno_id"], name: "index_mensalidades_on_aluno_id"
    t.index ["deleted_at"], name: "index_mensalidades_on_deleted_at"
    t.index ["plano_id"], name: "index_mensalidades_on_plano_id"
    t.index ["team_id"], name: "fk_rails_44ba3fd581"
  end

  create_table "modalidades", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "descricao"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "planos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "modalidade_id", null: false
    t.string "descricao"
    t.integer "valor_cents", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["modalidade_id"], name: "index_planos_on_modalidade_id"
  end

  create_table "produtos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "descricao"
    t.integer "preco_compra_cents", default: 0, null: false
    t.integer "preco_venda_cents", default: 0, null: false
    t.integer "categoria"
    t.integer "quantidade", default: 1
    t.bigint "ncm"
    t.integer "quantidade_minima", default: 1
    t.integer "itens_cx"
    t.date "data_validade"
    t.bigint "supplier_id"
    t.string "unidade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supplier_id"], name: "index_produtos_on_supplier_id"
  end

  create_table "recibos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "aluno_id", null: false
    t.bigint "cpf"
    t.integer "valor_cents", default: 0, null: false
    t.string "token"
    t.bigint "mensalidade_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["aluno_id"], name: "index_recibos_on_aluno_id"
    t.index ["mensalidade_id"], name: "index_recibos_on_mensalidade_id"
  end

  create_table "suppliers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "description"
    t.bigint "cnpj"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "team_accounts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.integer "balance_cents", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_team_accounts_on_deleted_at"
    t.index ["team_id"], name: "index_team_accounts_on_team_id"
  end

  create_table "teams", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "nome"
    t.bigint "cliente_id", null: false
    t.bigint "plano_id"
    t.bigint "modalidade_id", null: false
    t.boolean "ativo", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["cliente_id"], name: "index_teams_on_cliente_id"
    t.index ["deleted_at"], name: "index_teams_on_deleted_at"
    t.index ["modalidade_id"], name: "index_teams_on_modalidade_id"
    t.index ["plano_id"], name: "index_teams_on_plano_id"
  end

  create_table "tributos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "origem"
    t.string "ncm"
    t.string "cest"
    t.string "cst"
    t.string "cfop"
    t.integer "pis_cst"
    t.integer "confis_cst"
    t.bigint "produto_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["produto_id"], name: "index_tributos_on_produto_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "super_admin", default: false, null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "alunos", "modalidades"
  add_foreign_key "cash_ins", "mensalidades"
  add_foreign_key "comandas", "clientes"
  add_foreign_key "enderecos", "alunos"
  add_foreign_key "estoque_ins", "produtos"
  add_foreign_key "estoque_ins", "suppliers"
  add_foreign_key "estoque_ins", "users"
  add_foreign_key "estoque_outs", "produtos"
  add_foreign_key "estoque_outs", "users"
  add_foreign_key "invoices", "comandas"
  add_foreign_key "itens_comandas", "comandas"
  add_foreign_key "itens_comandas", "produtos"
  add_foreign_key "matriculas", "alunos"
  add_foreign_key "matriculas", "planos"
  add_foreign_key "mensalidades", "alunos"
  add_foreign_key "mensalidades", "planos"
  add_foreign_key "mensalidades", "teams"
  add_foreign_key "planos", "modalidades"
  add_foreign_key "produtos", "suppliers"
  add_foreign_key "recibos", "alunos"
  add_foreign_key "recibos", "mensalidades"
  add_foreign_key "team_accounts", "teams"
  add_foreign_key "teams", "clientes"
  add_foreign_key "teams", "modalidades"
  add_foreign_key "teams", "planos"
  add_foreign_key "tributos", "produtos"
end
