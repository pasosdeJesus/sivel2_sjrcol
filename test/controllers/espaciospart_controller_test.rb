require 'test_helper'

class EspaciospartControllerTest < ActionController::TestCase
  setup do
    skip
    @espaciopart = Espaciopart(:one)
  end

  test "should get index" do
    skip
    get :index
    assert_response :success
    assert_not_nil assigns(:espaciopart)
  end

  test "should get new" do
    skip
    get :new
    assert_response :success
  end

  test "should create espaciopart" do
    skip
    assert_difference('Espaciopart.count') do
      post :create, espaciopart: { created_at: @espaciopart.created_at, fechacreacion: @espaciopart.fechacreacion, fechadeshabilitacion: @espaciopart.fechadeshabilitacion, nombre: @espaciopart.nombre, observaciones: @espaciopart.observaciones, updated_at: @espaciopart.updated_at }
    end

    assert_redirected_to espaciopart_path(assigns(:espaciopart))
  end

  test "should show espaciopart" do
    skip
    get :show, id: @espaciopart
    assert_response :success
  end

  test "should get edit" do
    skip
    get :edit, id: @espaciopart
    assert_response :success
  end

  test "should update espaciopart" do
    skip
    patch :update, id: @espaciopart, espaciopart: { created_at: @espaciopart.created_at, fechacreacion: @espaciopart.fechacreacion, fechadeshabilitacion: @espaciopart.fechadeshabilitacion, nombre: @espaciopart.nombre, observaciones: @espaciopart.observaciones, updated_at: @espaciopart.updated_at }
    assert_redirected_to espaciopart_path(assigns(:espaciopart))
  end

  test "should destroy espaciopart" do
    skip
    assert_difference('Espaciopart.count', -1) do
      delete :destroy, id: @espaciopart
    end

    assert_redirected_to espaciospart_path
  end
end
