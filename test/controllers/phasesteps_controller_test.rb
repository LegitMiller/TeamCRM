require 'test_helper'

class PhasestepsControllerTest < ActionController::TestCase
  setup do
    @phasestep = phasesteps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:phasesteps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create phasestep" do
    assert_difference('Phasestep.count') do
      post :create, phasestep: { finishedtime: @phasestep.finishedtime, phase_id: @phasestep.phase_id, record_id: @phasestep.record_id }
    end

    assert_redirected_to phasestep_path(assigns(:phasestep))
  end

  test "should show phasestep" do
    get :show, id: @phasestep
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @phasestep
    assert_response :success
  end

  test "should update phasestep" do
    patch :update, id: @phasestep, phasestep: { finishedtime: @phasestep.finishedtime, phase_id: @phasestep.phase_id, record_id: @phasestep.record_id }
    assert_redirected_to phasestep_path(assigns(:phasestep))
  end

  test "should destroy phasestep" do
    assert_difference('Phasestep.count', -1) do
      delete :destroy, id: @phasestep
    end

    assert_redirected_to phasesteps_path
  end
end
