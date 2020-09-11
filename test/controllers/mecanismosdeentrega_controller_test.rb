require 'test_helper'

class MecanismosdeentregaControllerTest < ActionController::TestCase
  setup do
    skip
    @mecanismodeentrega = Mecanismodeentrega(:one)
  end

  test "should get index" do
    skip
    get :index
    assert_response :success
    assert_not_nil assigns(:mecanismodeentrega)
  end

  test "should get new" do
    skip
    get :new
    assert_response :success
  end

  test "should create mecanismodeentrega" do
    skip
    assert_difference('Mecanismodeentrega.count') do
      post :create, mecanismodeentrega: { created_at: @mecanismodeentrega.created_at, fechacreacion: @mecanismodeentrega.fechacreacion, fechadeshabilitacion: @mecanismodeentrega.fechadeshabilitacion, nombre: @mecanismodeentrega.nombre, observaciones: @mecanismodeentrega.observaciones, updated_at: @mecanismodeentrega.updated_at }
    end

    assert_redirected_to mecanismodeentrega_path(assigns(:mecanismodeentrega))
  end

  test "should show mecanismodeentrega" do
    skip
    get :show, id: @mecanismodeentrega
    assert_response :success
  end

  test "should get edit" do
    skip
    get :edit, id: @mecanismodeentrega
    assert_response :success
  end

  test "should update mecanismodeentrega" do
    skip
    patch :update, id: @mecanismodeentrega, mecanismodeentrega: { created_at: @mecanismodeentrega.created_at, fechacreacion: @mecanismodeentrega.fechacreacion, fechadeshabilitacion: @mecanismodeentrega.fechadeshabilitacion, nombre: @mecanismodeentrega.nombre, observaciones: @mecanismodeentrega.observaciones, updated_at: @mecanismodeentrega.updated_at }
    assert_redirected_to mecanismodeentrega_path(assigns(:mecanismodeentrega))
  end

  test "should destroy mecanismodeentrega" do
    skip
    assert_difference('Mecanismodeentrega.count', -1) do
      delete :destroy, id: @mecanismodeentrega
    end

    assert_redirected_to mecanismosdeentrega_path
  end
end
