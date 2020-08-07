require 'test_helper'

class MiembrosfamiliarControllerTest < ActionController::TestCase
  setup do
    skip
    @miembrofamiliar = Miembrofamiliar(:one)
  end

  test "should get index" do
    skip
    get :index
    assert_response :success
    assert_not_nil assigns(:miembrofamiliar)
  end

  test "should get new" do
    skip
    get :new
    assert_response :success
  end

  test "should create miembrofamiliar" do
    skip
    assert_difference('Miembrofamiliar.count') do
      post :create, miembrofamiliar: { created_at: @miembrofamiliar.created_at, fechacreacion: @miembrofamiliar.fechacreacion, fechadeshabilitacion: @miembrofamiliar.fechadeshabilitacion, nombre: @miembrofamiliar.nombre, observaciones: @miembrofamiliar.observaciones, updated_at: @miembrofamiliar.updated_at }
    end

    assert_redirected_to miembrofamiliar_path(assigns(:miembrofamiliar))
  end

  test "should show miembrofamiliar" do
    skip
    get :show, id: @miembrofamiliar
    assert_response :success
  end

  test "should get edit" do
    skip
    get :edit, id: @miembrofamiliar
    assert_response :success
  end

  test "should update miembrofamiliar" do
    skip
    patch :update, id: @miembrofamiliar, miembrofamiliar: { created_at: @miembrofamiliar.created_at, fechacreacion: @miembrofamiliar.fechacreacion, fechadeshabilitacion: @miembrofamiliar.fechadeshabilitacion, nombre: @miembrofamiliar.nombre, observaciones: @miembrofamiliar.observaciones, updated_at: @miembrofamiliar.updated_at }
    assert_redirected_to miembrofamiliar_path(assigns(:miembrofamiliar))
  end

  test "should destroy miembrofamiliar" do
    skip
    assert_difference('Miembrofamiliar.count', -1) do
      delete :destroy, id: @miembrofamiliar
    end

    assert_redirected_to miembrosfamiliar_path
  end
end
