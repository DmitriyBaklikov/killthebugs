require 'test_helper'

class FragmentsControllerTest < ActionController::TestCase
  setup do
    @fragment = fragments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fragments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fragment" do
    assert_difference('Fragment.count') do
      post :create, fragment: { code: @fragment.code, has_bugs: @fragment.has_bugs, hashie: @fragment.hashie, is_public: @fragment.is_public, title: @fragment.title }
    end

    assert_redirected_to fragment_path(assigns(:fragment))
  end

  test "should show fragment" do
    get :show, id: @fragment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fragment
    assert_response :success
  end

  test "should update fragment" do
    put :update, id: @fragment, fragment: { code: @fragment.code, has_bugs: @fragment.has_bugs, hashie: @fragment.hashie, is_public: @fragment.is_public, title: @fragment.title }
    assert_redirected_to fragment_path(assigns(:fragment))
  end

  test "should destroy fragment" do
    assert_difference('Fragment.count', -1) do
      delete :destroy, id: @fragment
    end

    assert_redirected_to fragments_path
  end
end
