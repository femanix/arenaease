require 'test_helper'

class FormaPagamentosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @forma_pagamento = forma_pagamentos(:one)
  end

  test "should get index" do
    get forma_pagamentos_url
    assert_response :success
  end

  test "should get new" do
    get new_forma_pagamento_url
    assert_response :success
  end

  test "should create forma_pagamento" do
    assert_difference('FormaPagamento.count') do
      post forma_pagamentos_url, params: { forma_pagamento: { descricao: @forma_pagamento.descricao } }
    end

    assert_redirected_to forma_pagamento_url(FormaPagamento.last)
  end

  test "should show forma_pagamento" do
    get forma_pagamento_url(@forma_pagamento)
    assert_response :success
  end

  test "should get edit" do
    get edit_forma_pagamento_url(@forma_pagamento)
    assert_response :success
  end

  test "should update forma_pagamento" do
    patch forma_pagamento_url(@forma_pagamento), params: { forma_pagamento: { descricao: @forma_pagamento.descricao } }
    assert_redirected_to forma_pagamento_url(@forma_pagamento)
  end

  test "should destroy forma_pagamento" do
    assert_difference('FormaPagamento.count', -1) do
      delete forma_pagamento_url(@forma_pagamento)
    end

    assert_redirected_to forma_pagamentos_url
  end
end
