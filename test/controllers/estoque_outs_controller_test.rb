require 'test_helper'

class EstoqueOutsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @estoque_out = estoque_outs(:one)
  end

  test "should get index" do
    get estoque_outs_url
    assert_response :success
  end

  test "should get new" do
    get new_estoque_out_url
    assert_response :success
  end

  test "should create estoque_out" do
    assert_difference('EstoqueOut.count') do
      post estoque_outs_url, params: { estoque_out: { admin_id: @estoque_out.admin_id, produto_id: @estoque_out.produto_id, quantidade: @estoque_out.quantidade } }
    end

    assert_redirected_to estoque_out_url(EstoqueOut.last)
  end

  test "should show estoque_out" do
    get estoque_out_url(@estoque_out)
    assert_response :success
  end

  test "should get edit" do
    get edit_estoque_out_url(@estoque_out)
    assert_response :success
  end

  test "should update estoque_out" do
    patch estoque_out_url(@estoque_out), params: { estoque_out: { admin_id: @estoque_out.admin_id, produto_id: @estoque_out.produto_id, quantidade: @estoque_out.quantidade } }
    assert_redirected_to estoque_out_url(@estoque_out)
  end

  test "should destroy estoque_out" do
    assert_difference('EstoqueOut.count', -1) do
      delete estoque_out_url(@estoque_out)
    end

    assert_redirected_to estoque_outs_url
  end
end
