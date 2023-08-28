require 'test_helper'

class ComandasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comanda = comandas(:one)
  end

  test "should get index" do
    get comandas_url
    assert_response :success
  end

  test "should get new" do
    get new_comanda_url
    assert_response :success
  end

  test "should create comanda" do
    assert_difference('Comanda.count') do
      post comandas_url, params: { comanda: { cliente_id: @comanda.cliente_id, forma_pagamento_id: @comanda.forma_pagamento_id, itens: @comanda.itens, valor_total: @comanda.valor_total } }
    end

    assert_redirected_to comanda_url(Comanda.last)
  end

  test "should show comanda" do
    get comanda_url(@comanda)
    assert_response :success
  end

  test "should get edit" do
    get edit_comanda_url(@comanda)
    assert_response :success
  end

  test "should update comanda" do
    patch comanda_url(@comanda), params: { comanda: { cliente_id: @comanda.cliente_id, forma_pagamento_id: @comanda.forma_pagamento_id, itens: @comanda.itens, valor_total: @comanda.valor_total } }
    assert_redirected_to comanda_url(@comanda)
  end

  test "should destroy comanda" do
    assert_difference('Comanda.count', -1) do
      delete comanda_url(@comanda)
    end

    assert_redirected_to comandas_url
  end
end
