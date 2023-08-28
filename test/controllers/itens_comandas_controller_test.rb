require 'test_helper'

class ItensComandasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @itens_comanda = itens_comandas(:one)
  end

  test "should get index" do
    get itens_comandas_url
    assert_response :success
  end

  test "should get new" do
    get new_itens_comanda_url
    assert_response :success
  end

  test "should create itens_comanda" do
    assert_difference('ItensComanda.count') do
      post itens_comandas_url, params: { itens_comanda: { comanda_id: @itens_comanda.comanda_id, produto_id: @itens_comanda.produto_id, quantidade: @itens_comanda.quantidade, valor: @itens_comanda.valor } }
    end

    assert_redirected_to itens_comanda_url(ItensComanda.last)
  end

  test "should show itens_comanda" do
    get itens_comanda_url(@itens_comanda)
    assert_response :success
  end

  test "should get edit" do
    get edit_itens_comanda_url(@itens_comanda)
    assert_response :success
  end

  test "should update itens_comanda" do
    patch itens_comanda_url(@itens_comanda), params: { itens_comanda: { comanda_id: @itens_comanda.comanda_id, produto_id: @itens_comanda.produto_id, quantidade: @itens_comanda.quantidade, valor: @itens_comanda.valor } }
    assert_redirected_to itens_comanda_url(@itens_comanda)
  end

  test "should destroy itens_comanda" do
    assert_difference('ItensComanda.count', -1) do
      delete itens_comanda_url(@itens_comanda)
    end

    assert_redirected_to itens_comandas_url
  end
end
