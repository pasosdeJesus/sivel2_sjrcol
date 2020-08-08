require 'test_helper'

class TiposproteccionControllerTest < ActionController::TestCase
  setup do
    skip
    @tipoproteccion = Tipoproteccion(:one)
  end

  test "should get index" do
    skip
    get :index
    assert_response :success
    assert_not_nil assigns(:tipoproteccion)
  end

  test "should get new" do
    skip
    get :new
    assert_response :success
  end

  test "should create tipoproteccion" do
    skip
    assert_difference('Tipoproteccion.count') do
      post :create, tipoproteccion: { created_at: @tipoproteccion.created_at, fechacreacion: @tipoproteccion.fechacreacion, fechadeshabilitacion: @tipoproteccion.fechadeshabilitacion, nombre: @tipoproteccion.nombre, observaciones: @tipoproteccion.observaciones, updated_at: @tipoproteccion.updated_at }
    end

    assert_redirected_to tipoproteccion_path(assigns(:tipoproteccion))
  end

  test "should show tipoproteccion" do
    skip
    get :show, id: @tipoproteccion
    assert_response :success
  end

  test "should get edit" do
    skip
    get :edit, id: @tipoproteccion
    assert_response :success
  end

  test "should update tipoproteccion" do
    skip
    patch :update, id: @tipoproteccion, tipoproteccion: { created_at: @tipoproteccion.created_at, fechacreacion: @tipoproteccion.fechacreacion, fechadeshabilitacion: @tipoproteccion.fechadeshabilitacion, nombre: @tipoproteccion.nombre, observaciones: @tipoproteccion.observaciones, updated_at: @tipoproteccion.updated_at }
    assert_redirected_to tipoproteccion_path(assigns(:tipoproteccion))
  end

  test "should destroy tipoproteccion" do
    skip
    assert_difference('Tipoproteccion.count', -1) do
      delete :destroy, id: @tipoproteccion
    end

    assert_redirected_to tiposproteccion_path
  end
end
