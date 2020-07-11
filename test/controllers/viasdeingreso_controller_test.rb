require 'test_helper'

class ViasdeingresoControllerTest < ActionController::TestCase
  setup do
    skip
    @viadeingreso = Viadeingreso(:one)
  end

  test "should get index" do
    skip
    get :index
    assert_response :success
    assert_not_nil assigns(:viadeingreso)
  end

  test "should get new" do
    skip
    get :new
    assert_response :success
  end

  test "should create viadeingreso" do
    skip
    assert_difference('Viadeingreso.count') do
      post :create, viadeingreso: { created_at: @viadeingreso.created_at, fechacreacion: @viadeingreso.fechacreacion, fechadeshabilitacion: @viadeingreso.fechadeshabilitacion, nombre: @viadeingreso.nombre, observaciones: @viadeingreso.observaciones, updated_at: @viadeingreso.updated_at }
    end

    assert_redirected_to viadeingreso_path(assigns(:viadeingreso))
  end

  test "should show viadeingreso" do
    skip
    get :show, id: @viadeingreso
    assert_response :success
  end

  test "should get edit" do
    skip
    get :edit, id: @viadeingreso
    assert_response :success
  end

  test "should update viadeingreso" do
    skip
    patch :update, id: @viadeingreso, viadeingreso: { created_at: @viadeingreso.created_at, fechacreacion: @viadeingreso.fechacreacion, fechadeshabilitacion: @viadeingreso.fechadeshabilitacion, nombre: @viadeingreso.nombre, observaciones: @viadeingreso.observaciones, updated_at: @viadeingreso.updated_at }
    assert_redirected_to viadeingreso_path(assigns(:viadeingreso))
  end

  test "should destroy viadeingreso" do
    skip
    assert_difference('Viadeingreso.count', -1) do
      delete :destroy, id: @viadeingreso
    end

    assert_redirected_to viasdeingreso_path
  end
end
