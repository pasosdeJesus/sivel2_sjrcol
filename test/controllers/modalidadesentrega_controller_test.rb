require 'test_helper'

class ModalidadesentregaControllerTest < ActionController::TestCase
  setup do
    skip
    @modalidadentrega = Modalidadentrega(:one)
  end

  test "should get index" do
    skip
    get :index
    assert_response :success
    assert_not_nil assigns(:modalidadentrega)
  end

  test "should get new" do
    skip
    get :new
    assert_response :success
  end

  test "should create modalidadentrega" do
    skip
    assert_difference('Modalidadentrega.count') do
      post :create, modalidadentrega: { created_at: @modalidadentrega.created_at, fechacreacion: @modalidadentrega.fechacreacion, fechadeshabilitacion: @modalidadentrega.fechadeshabilitacion, nombre: @modalidadentrega.nombre, observaciones: @modalidadentrega.observaciones, updated_at: @modalidadentrega.updated_at }
    end

    assert_redirected_to modalidadentrega_path(assigns(:modalidadentrega))
  end

  test "should show modalidadentrega" do
    skip
    get :show, id: @modalidadentrega
    assert_response :success
  end

  test "should get edit" do
    skip
    get :edit, id: @modalidadentrega
    assert_response :success
  end

  test "should update modalidadentrega" do
    skip
    patch :update, id: @modalidadentrega, modalidadentrega: { created_at: @modalidadentrega.created_at, fechacreacion: @modalidadentrega.fechacreacion, fechadeshabilitacion: @modalidadentrega.fechadeshabilitacion, nombre: @modalidadentrega.nombre, observaciones: @modalidadentrega.observaciones, updated_at: @modalidadentrega.updated_at }
    assert_redirected_to modalidadentrega_path(assigns(:modalidadentrega))
  end

  test "should destroy modalidadentrega" do
    skip
    assert_difference('Modalidadentrega.count', -1) do
      delete :destroy, id: @modalidadentrega
    end

    assert_redirected_to modalidadesentrega_path
  end
end
