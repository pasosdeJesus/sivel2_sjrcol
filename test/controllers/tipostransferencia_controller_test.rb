require 'test_helper'

class TipostransferenciaControllerTest < ActionController::TestCase
  setup do
    skip
    @tipotransferencia = Tipotransferencia(:one)
  end

  test "should get index" do
    skip
    get :index
    assert_response :success
    assert_not_nil assigns(:tipotransferencia)
  end

  test "should get new" do
    skip
    get :new
    assert_response :success
  end

  test "should create tipotransferencia" do
    skip
    assert_difference('Tipotransferencia.count') do
      post :create, tipotransferencia: { created_at: @tipotransferencia.created_at, fechacreacion: @tipotransferencia.fechacreacion, fechadeshabilitacion: @tipotransferencia.fechadeshabilitacion, nombre: @tipotransferencia.nombre, observaciones: @tipotransferencia.observaciones, updated_at: @tipotransferencia.updated_at }
    end

    assert_redirected_to tipotransferencia_path(assigns(:tipotransferencia))
  end

  test "should show tipotransferencia" do
    skip
    get :show, id: @tipotransferencia
    assert_response :success
  end

  test "should get edit" do
    skip
    get :edit, id: @tipotransferencia
    assert_response :success
  end

  test "should update tipotransferencia" do
    skip
    patch :update, id: @tipotransferencia, tipotransferencia: { created_at: @tipotransferencia.created_at, fechacreacion: @tipotransferencia.fechacreacion, fechadeshabilitacion: @tipotransferencia.fechadeshabilitacion, nombre: @tipotransferencia.nombre, observaciones: @tipotransferencia.observaciones, updated_at: @tipotransferencia.updated_at }
    assert_redirected_to tipotransferencia_path(assigns(:tipotransferencia))
  end

  test "should destroy tipotransferencia" do
    skip
    assert_difference('Tipotransferencia.count', -1) do
      delete :destroy, id: @tipotransferencia
    end

    assert_redirected_to tipostransferencia_path
  end
end
