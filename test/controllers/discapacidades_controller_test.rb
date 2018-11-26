require 'test_helper'

class DiscapacidadesControllerTest < ActionController::TestCase
  setup do
    skip
    @discapacidad = Discapacidad(:one)
  end

  test "should get index" do
    skip
    get :index
    assert_response :success
    assert_not_nil assigns(:discapacidad)
  end

  test "should get new" do
    skip
    get :new
    assert_response :success
  end

  test "should create discapacidad" do
    skip
    assert_difference('Discapacidad.count') do
      post :create, discapacidad: { created_at: @discapacidad.created_at, fechacreacion: @discapacidad.fechacreacion, fechadeshabilitacion: @discapacidad.fechadeshabilitacion, nombre: @discapacidad.nombre, observaciones: @discapacidad.observaciones, updated_at: @discapacidad.updated_at }
    end

    assert_redirected_to discapacidad_path(assigns(:discapacidad))
  end

  test "should show discapacidad" do
    skip
    get :show, id: @discapacidad
    assert_response :success
  end

  test "should get edit" do
    skip
    get :edit, id: @discapacidad
    assert_response :success
  end

  test "should update discapacidad" do
    skip
    patch :update, id: @discapacidad, discapacidad: { created_at: @discapacidad.created_at, fechacreacion: @discapacidad.fechacreacion, fechadeshabilitacion: @discapacidad.fechadeshabilitacion, nombre: @discapacidad.nombre, observaciones: @discapacidad.observaciones, updated_at: @discapacidad.updated_at }
    assert_redirected_to discapacidad_path(assigns(:discapacidad))
  end

  test "should destroy discapacidad" do
    skip
    assert_difference('Discapacidad.count', -1) do
      delete :destroy, id: @discapacidad
    end

    assert_redirected_to discapacidades_path
  end
end
