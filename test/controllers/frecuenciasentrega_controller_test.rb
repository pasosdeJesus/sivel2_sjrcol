require 'test_helper'

class FrecuenciasentregaControllerTest < ActionController::TestCase
  setup do
    skip
    @frecuenciaentrega = Frecuenciaentrega(:one)
  end

  test "should get index" do
    skip
    get :index
    assert_response :success
    assert_not_nil assigns(:frecuenciaentrega)
  end

  test "should get new" do
    skip
    get :new
    assert_response :success
  end

  test "should create frecuenciaentrega" do
    skip
    assert_difference('Frecuenciaentrega.count') do
      post :create, frecuenciaentrega: { created_at: @frecuenciaentrega.created_at, fechacreacion: @frecuenciaentrega.fechacreacion, fechadeshabilitacion: @frecuenciaentrega.fechadeshabilitacion, nombre: @frecuenciaentrega.nombre, observaciones: @frecuenciaentrega.observaciones, updated_at: @frecuenciaentrega.updated_at }
    end

    assert_redirected_to frecuenciaentrega_path(assigns(:frecuenciaentrega))
  end

  test "should show frecuenciaentrega" do
    skip
    get :show, id: @frecuenciaentrega
    assert_response :success
  end

  test "should get edit" do
    skip
    get :edit, id: @frecuenciaentrega
    assert_response :success
  end

  test "should update frecuenciaentrega" do
    skip
    patch :update, id: @frecuenciaentrega, frecuenciaentrega: { created_at: @frecuenciaentrega.created_at, fechacreacion: @frecuenciaentrega.fechacreacion, fechadeshabilitacion: @frecuenciaentrega.fechadeshabilitacion, nombre: @frecuenciaentrega.nombre, observaciones: @frecuenciaentrega.observaciones, updated_at: @frecuenciaentrega.updated_at }
    assert_redirected_to frecuenciaentrega_path(assigns(:frecuenciaentrega))
  end

  test "should destroy frecuenciaentrega" do
    skip
    assert_difference('Frecuenciaentrega.count', -1) do
      delete :destroy, id: @frecuenciaentrega
    end

    assert_redirected_to frecuenciasentrega_path
  end
end
