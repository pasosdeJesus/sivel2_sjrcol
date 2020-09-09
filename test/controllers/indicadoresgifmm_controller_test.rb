require 'test_helper'

class IndicadoresgifmmControllerTest < ActionController::TestCase
  setup do
    skip
    @indicadorgifmm = Indicadorgifmm(:one)
  end

  test "should get index" do
    skip
    get :index
    assert_response :success
    assert_not_nil assigns(:indicadorgifmm)
  end

  test "should get new" do
    skip
    get :new
    assert_response :success
  end

  test "should create indicadorgifmm" do
    skip
    assert_difference('Indicadorgifmm.count') do
      post :create, indicadorgifmm: { created_at: @indicadorgifmm.created_at, fechacreacion: @indicadorgifmm.fechacreacion, fechadeshabilitacion: @indicadorgifmm.fechadeshabilitacion, nombre: @indicadorgifmm.nombre, observaciones: @indicadorgifmm.observaciones, updated_at: @indicadorgifmm.updated_at }
    end

    assert_redirected_to indicadorgifmm_path(assigns(:indicadorgifmm))
  end

  test "should show indicadorgifmm" do
    skip
    get :show, id: @indicadorgifmm
    assert_response :success
  end

  test "should get edit" do
    skip
    get :edit, id: @indicadorgifmm
    assert_response :success
  end

  test "should update indicadorgifmm" do
    skip
    patch :update, id: @indicadorgifmm, indicadorgifmm: { created_at: @indicadorgifmm.created_at, fechacreacion: @indicadorgifmm.fechacreacion, fechadeshabilitacion: @indicadorgifmm.fechadeshabilitacion, nombre: @indicadorgifmm.nombre, observaciones: @indicadorgifmm.observaciones, updated_at: @indicadorgifmm.updated_at }
    assert_redirected_to indicadorgifmm_path(assigns(:indicadorgifmm))
  end

  test "should destroy indicadorgifmm" do
    skip
    assert_difference('Indicadorgifmm.count', -1) do
      delete :destroy, id: @indicadorgifmm
    end

    assert_redirected_to indicadoresgifmm_path
  end
end
