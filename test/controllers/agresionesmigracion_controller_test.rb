require 'test_helper'

class AgresionesmigracionControllerTest < ActionController::TestCase
  setup do
    skip
    @agresionmigracion = Agresionmigracion(:one)
  end

  test "should get index" do
    skip
    get :index
    assert_response :success
    assert_not_nil assigns(:agresionmigracion)
  end

  test "should get new" do
    skip
    get :new
    assert_response :success
  end

  test "should create agresionmigracion" do
    skip
    assert_difference('Agresionmigracion.count') do
      post :create, agresionmigracion: { created_at: @agresionmigracion.created_at, fechacreacion: @agresionmigracion.fechacreacion, fechadeshabilitacion: @agresionmigracion.fechadeshabilitacion, nombre: @agresionmigracion.nombre, observaciones: @agresionmigracion.observaciones, updated_at: @agresionmigracion.updated_at }
    end

    assert_redirected_to agresionmigracion_path(assigns(:agresionmigracion))
  end

  test "should show agresionmigracion" do
    skip
    get :show, id: @agresionmigracion
    assert_response :success
  end

  test "should get edit" do
    skip
    get :edit, id: @agresionmigracion
    assert_response :success
  end

  test "should update agresionmigracion" do
    skip
    patch :update, id: @agresionmigracion, agresionmigracion: { created_at: @agresionmigracion.created_at, fechacreacion: @agresionmigracion.fechacreacion, fechadeshabilitacion: @agresionmigracion.fechadeshabilitacion, nombre: @agresionmigracion.nombre, observaciones: @agresionmigracion.observaciones, updated_at: @agresionmigracion.updated_at }
    assert_redirected_to agresionmigracion_path(assigns(:agresionmigracion))
  end

  test "should destroy agresionmigracion" do
    skip
    assert_difference('Agresionmigracion.count', -1) do
      delete :destroy, id: @agresionmigracion
    end

    assert_redirected_to agresionesmigracion_path
  end
end
