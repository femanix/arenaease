require 'test_helper'

class EstoqueInsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @estoque_in = estoque_ins(:one)
  end

  test "should get index" do
    get estoque_ins_url
    assert_response :success
  end

  test "should get new" do
    get new_estoque_in_url
    assert_response :success
  end

  test "should create estoque_in" do
    assert_difference('EstoqueIn.count') do
      post estoque_ins_url, params: { estoque_in: { admin_id: @estoque_in.admin_id, fornecedor_id: @estoque_in.fornecedor_id, produto_id: @estoque_in.produto_id, quantidade: @estoque_in.quantidade, valor: @estoque_in.valor } }
    end

    assert_redirected_to estoque_in_url(EstoqueIn.last)
  end

  test "should show estoque_in" do
    get estoque_in_url(@estoque_in)
    assert_response :success
  end

  test "should get edit" do
    get edit_estoque_in_url(@estoque_in)
    assert_response :success
  end

  test "should update estoque_in" do
    patch estoque_in_url(@estoque_in), params: { estoque_in: { admin_id: @estoque_in.admin_id, fornecedor_id: @estoque_in.fornecedor_id, produto_id: @estoque_in.produto_id, quantidade: @estoque_in.quantidade, valor: @estoque_in.valor } }
    assert_redirected_to estoque_in_url(@estoque_in)
  end

  test "should destroy estoque_in" do
    assert_difference('EstoqueIn.count', -1) do
      delete estoque_in_url(@estoque_in)
    end

    assert_redirected_to estoque_ins_url
  end
end
