require "test_helper"

class TeamAccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @team_account = team_accounts(:one)
  end

  test "should get index" do
    get team_accounts_url
    assert_response :success
  end

  test "should get new" do
    get new_team_account_url
    assert_response :success
  end

  test "should create team_account" do
    assert_difference('TeamAccount.count') do
      post team_accounts_url, params: { team_account: { balance_cents: @team_account.balance_cents, team_id: @team_account.team_id } }
    end

    assert_redirected_to team_account_url(TeamAccount.last)
  end

  test "should show team_account" do
    get team_account_url(@team_account)
    assert_response :success
  end

  test "should get edit" do
    get edit_team_account_url(@team_account)
    assert_response :success
  end

  test "should update team_account" do
    patch team_account_url(@team_account), params: { team_account: { balance_cents: @team_account.balance_cents, team_id: @team_account.team_id } }
    assert_redirected_to team_account_url(@team_account)
  end

  test "should destroy team_account" do
    assert_difference('TeamAccount.count', -1) do
      delete team_account_url(@team_account)
    end

    assert_redirected_to team_accounts_url
  end
end
