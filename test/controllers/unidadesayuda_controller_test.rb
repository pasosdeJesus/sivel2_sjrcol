require 'test_helper'

class UnidadesayudaControllerTest < ActionController::TestCase
  setup do
    skip
    @unidadayuda = Unidadayuda(:one)
  end

  test "should get index" do
    skip
    get :index
    assert_response :success
    assert_not_nil assigns(:unidadayuda)
  end

  test "should get new" do
    skip
    get :new
    assert_response :success
  end

  test "should create unidadayuda" do
    skip
    assert_difference('Unidadayuda.count') do
      post :create, unidadayuda: { created_at: @unidadayuda.created_at, fechacreacion: @unidadayuda.fechacreacion, fechadeshabilitacion: @unidadayuda.fechadeshabilitacion, nombre: @unidadayuda.nombre, observaciones: @unidadayuda.observaciones, updated_at: @unidadayuda.updated_at }
    end

    assert_redirected_to unidadayuda_path(assigns(:unidadayuda))
  end

  test "should show unidadayuda" do
    skip
    get :show, id: @unidadayuda
    assert_response :success
  end

  test "should get edit" do
    skip
    get :edit, id: @unidadayuda
    assert_response :success
  end

  test "should update unidadayuda" do
    skip
    patch :update, id: @unidadayuda, unidadayuda: { created_at: @unidadayuda.created_at, fechacreacion: @unidadayuda.fechacreacion, fechadeshabilitacion: @unidadayuda.fechadeshabilitacion, nombre: @unidadayuda.nombre, observaciones: @unidadayuda.observaciones, updated_at: @unidadayuda.updated_at }
    assert_redirected_to unidadayuda_path(assigns(:unidadayuda))
  end

  test "should destroy unidadayuda" do
    skip
    assert_difference('Unidadayuda.count', -1) do
      delete :destroy, id: @unidadayuda
    end

    assert_redirected_to unidadesayuda_path
  end
end
