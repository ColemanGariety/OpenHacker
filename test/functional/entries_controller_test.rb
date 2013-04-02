require 'test_helper'

class EntriesControllerTest < ActionController::TestCase
  setup do
    @entry = entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create entry" do
    assert_difference('Entry.count') do
      post :create, entry: { description: @entry.description, receiving_challenge_id: @entry.receiving_challenge_id, repo_url: @entry.repo_url, submitting_user_id: @entry.submitting_user_id, thumb_url: @entry.thumb_url, title: @entry.title }
    end

    assert_redirected_to entry_path(assigns(:entry))
  end

  test "should show entry" do
    get :show, id: @entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @entry
    assert_response :success
  end

  test "should update entry" do
    put :update, id: @entry, entry: { description: @entry.description, receiving_challenge_id: @entry.receiving_challenge_id, repo_url: @entry.repo_url, submitting_user_id: @entry.submitting_user_id, thumb_url: @entry.thumb_url, title: @entry.title }
    assert_redirected_to entry_path(assigns(:entry))
  end

  test "should destroy entry" do
    assert_difference('Entry.count', -1) do
      delete :destroy, id: @entry
    end

    assert_redirected_to entries_path
  end
end
