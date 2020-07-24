require 'test_helper'

class CausasagresionControllerTest < ActionController::TestCase
  setup do
    skip
    @causaagresion = Causaagresion(:one)
  end

  test "should get index" do
    skip
    get :index
    assert_response :success
    assert_not_nil assigns(:causaagresion)
  end

  test "should get new" do
    skip
    get :new
    assert_response :success
  end

  test "should create causaagresion" do
    skip
    assert_difference('Causaagresion.count') do
      post :create, causaagresion: { created_at: @causaagresion.created_at, fechacreacion: @causaagresion.fechacreacion, fechadeshabilitacion: @causaagresion.fechadeshabilitacion, nombre: @causaagresion.nombre, observaciones: @causaagresion.observaciones, updated_at: @causaagresion.updated_at }
    end

    assert_redirected_to causaagresion_path(assigns(:causaagresion))
  end

  test "should show causaagresion" do
    skip
    get :show, id: @causaagresion
    assert_response :success
  end

  test "should get edit" do
    skip
    get :edit, id: @causaagresion
    assert_response :success
  end

  test "should update causaagresion" do
    skip
    patch :update, id: @causaagresion, causaagresion: { created_at: @causaagresion.created_at, fechacreacion: @causaagresion.fechacreacion, fechadeshabilitacion: @causaagresion.fechadeshabilitacion, nombre: @causaagresion.nombre, observaciones: @causaagresion.observaciones, updated_at: @causaagresion.updated_at }
    assert_redirected_to causaagresion_path(assigns(:causaagresion))
  end

  test "should destroy causaagresion" do
    skip
    assert_difference('Causaagresion.count', -1) do
      delete :destroy, id: @causaagresion
    end

    assert_redirected_to causasagresion_path
  end
end
