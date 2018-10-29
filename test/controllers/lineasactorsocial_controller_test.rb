require 'test_helper'

class LineasactorsocialControllerTest < ActionController::TestCase
  setup do
    skip
    @lineaactorsocial = Lineaactorsocial(:one)
  end

  test "should get index" do
    skip
    get :index
    assert_response :success
    assert_not_nil assigns(:lineaactorsocial)
  end

  test "should get new" do
    skip
    get :new
    assert_response :success
  end

  test "should create lineaactorsocial" do
    skip
    assert_difference('Lineaactorsocial.count') do
      post :create, lineaactorsocial: { created_at: @lineaactorsocial.created_at, fechacreacion: @lineaactorsocial.fechacreacion, fechadeshabilitacion: @lineaactorsocial.fechadeshabilitacion, nombre: @lineaactorsocial.nombre, observaciones: @lineaactorsocial.observaciones, updated_at: @lineaactorsocial.updated_at }
    end

    assert_redirected_to lineaactorsocial_path(assigns(:lineaactorsocial))
  end

  test "should show lineaactorsocial" do
    skip
    get :show, id: @lineaactorsocial
    assert_response :success
  end

  test "should get edit" do
    skip
    get :edit, id: @lineaactorsocial
    assert_response :success
  end

  test "should update lineaactorsocial" do
    skip
    patch :update, id: @lineaactorsocial, lineaactorsocial: { created_at: @lineaactorsocial.created_at, fechacreacion: @lineaactorsocial.fechacreacion, fechadeshabilitacion: @lineaactorsocial.fechadeshabilitacion, nombre: @lineaactorsocial.nombre, observaciones: @lineaactorsocial.observaciones, updated_at: @lineaactorsocial.updated_at }
    assert_redirected_to lineaactorsocial_path(assigns(:lineaactorsocial))
  end

  test "should destroy lineaactorsocial" do
    skip
    assert_difference('Lineaactorsocial.count', -1) do
      delete :destroy, id: @lineaactorsocial
    end

    assert_redirected_to lineaactorsociales_path
  end
end
