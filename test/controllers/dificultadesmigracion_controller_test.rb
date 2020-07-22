require 'test_helper'

class DificultadesmigracionControllerTest < ActionController::TestCase
  setup do
    skip
    @dificultadmigracion = Dificultadmigracion(:one)
  end

  test "should get index" do
    skip
    get :index
    assert_response :success
    assert_not_nil assigns(:dificultadmigracion)
  end

  test "should get new" do
    skip
    get :new
    assert_response :success
  end

  test "should create dificultadmigracion" do
    skip
    assert_difference('Dificultadmigracion.count') do
      post :create, dificultadmigracion: { created_at: @dificultadmigracion.created_at, fechacreacion: @dificultadmigracion.fechacreacion, fechadeshabilitacion: @dificultadmigracion.fechadeshabilitacion, nombre: @dificultadmigracion.nombre, observaciones: @dificultadmigracion.observaciones, updated_at: @dificultadmigracion.updated_at }
    end

    assert_redirected_to dificultadmigracion_path(assigns(:dificultadmigracion))
  end

  test "should show dificultadmigracion" do
    skip
    get :show, id: @dificultadmigracion
    assert_response :success
  end

  test "should get edit" do
    skip
    get :edit, id: @dificultadmigracion
    assert_response :success
  end

  test "should update dificultadmigracion" do
    skip
    patch :update, id: @dificultadmigracion, dificultadmigracion: { created_at: @dificultadmigracion.created_at, fechacreacion: @dificultadmigracion.fechacreacion, fechadeshabilitacion: @dificultadmigracion.fechadeshabilitacion, nombre: @dificultadmigracion.nombre, observaciones: @dificultadmigracion.observaciones, updated_at: @dificultadmigracion.updated_at }
    assert_redirected_to dificultadmigracion_path(assigns(:dificultadmigracion))
  end

  test "should destroy dificultadmigracion" do
    skip
    assert_difference('Dificultadmigracion.count', -1) do
      delete :destroy, id: @dificultadmigracion
    end

    assert_redirected_to dificultadesmigracion_path
  end
end
