require 'test_helper'

class AutoridadesrefugioControllerTest < ActionController::TestCase
  setup do
    skip
    @autoridadrefugio = Autoridadrefugio(:one)
  end

  test "should get index" do
    skip
    get :index
    assert_response :success
    assert_not_nil assigns(:autoridadrefugio)
  end

  test "should get new" do
    skip
    get :new
    assert_response :success
  end

  test "should create autoridadrefugio" do
    skip
    assert_difference('Autoridadrefugio.count') do
      post :create, autoridadrefugio: { created_at: @autoridadrefugio.created_at, fechacreacion: @autoridadrefugio.fechacreacion, fechadeshabilitacion: @autoridadrefugio.fechadeshabilitacion, nombre: @autoridadrefugio.nombre, observaciones: @autoridadrefugio.observaciones, updated_at: @autoridadrefugio.updated_at }
    end

    assert_redirected_to autoridadrefugio_path(assigns(:autoridadrefugio))
  end

  test "should show autoridadrefugio" do
    skip
    get :show, id: @autoridadrefugio
    assert_response :success
  end

  test "should get edit" do
    skip
    get :edit, id: @autoridadrefugio
    assert_response :success
  end

  test "should update autoridadrefugio" do
    skip
    patch :update, id: @autoridadrefugio, autoridadrefugio: { created_at: @autoridadrefugio.created_at, fechacreacion: @autoridadrefugio.fechacreacion, fechadeshabilitacion: @autoridadrefugio.fechadeshabilitacion, nombre: @autoridadrefugio.nombre, observaciones: @autoridadrefugio.observaciones, updated_at: @autoridadrefugio.updated_at }
    assert_redirected_to autoridadrefugio_path(assigns(:autoridadrefugio))
  end

  test "should destroy autoridadrefugio" do
    skip
    assert_difference('Autoridadrefugio.count', -1) do
      delete :destroy, id: @autoridadrefugio
    end

    assert_redirected_to autoridadesrefugio_path
  end
end
