require 'test_helper'

class MessgsControllerTest < ActionController::TestCase
  setup do
    @messg = messgs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:messgs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create messg" do
    assert_difference('Messg.count') do
      post :create, messg: { closing: @messg.closing, intro: @messg.intro, message: @messg.message, progression_id: @messg.progression_id }
    end

    assert_redirected_to messg_path(assigns(:messg))
  end

  test "should show messg" do
    get :show, id: @messg
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @messg
    assert_response :success
  end

  test "should update messg" do
    patch :update, id: @messg, messg: { closing: @messg.closing, intro: @messg.intro, message: @messg.message, progression_id: @messg.progression_id }
    assert_redirected_to messg_path(assigns(:messg))
  end

  test "should destroy messg" do
    assert_difference('Messg.count', -1) do
      delete :destroy, id: @messg
    end

    assert_redirected_to messgs_path
  end
end
