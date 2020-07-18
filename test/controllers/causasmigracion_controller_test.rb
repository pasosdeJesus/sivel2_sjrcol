require 'test_helper'

class CausasmigracionControllerTest < ActionController::TestCase
  setup do
    skip
    @causamigracion = Causamigracion(:one)
  end

  test "should get index" do
    skip
    get :index
    assert_response :success
    assert_not_nil assigns(:causamigracion)
  end

  test "should get new" do
    skip
    get :new
    assert_response :success
  end

  test "should create causamigracion" do
    skip
    assert_difference('Causamigracion.count') do
      post :create, causamigracion: { created_at: @causamigracion.created_at, fechacreacion: @causamigracion.fechacreacion, fechadeshabilitacion: @causamigracion.fechadeshabilitacion, nombre: @causamigracion.nombre, observaciones: @causamigracion.observaciones, updated_at: @causamigracion.updated_at }
    end

    assert_redirected_to causamigracion_path(assigns(:causamigracion))
  end

  test "should show causamigracion" do
    skip
    get :show, id: @causamigracion
    assert_response :success
  end

  test "should get edit" do
    skip
    get :edit, id: @causamigracion
    assert_response :success
  end

  test "should update causamigracion" do
    skip
    patch :update, id: @causamigracion, causamigracion: { created_at: @causamigracion.created_at, fechacreacion: @causamigracion.fechacreacion, fechadeshabilitacion: @causamigracion.fechadeshabilitacion, nombre: @causamigracion.nombre, observaciones: @causamigracion.observaciones, updated_at: @causamigracion.updated_at }
    assert_redirected_to causamigracion_path(assigns(:causamigracion))
  end

  test "should destroy causamigracion" do
    skip
    assert_difference('Causamigracion.count', -1) do
      delete :destroy, id: @causamigracion
    end

    assert_redirected_to causasmigracion_path
  end
end
