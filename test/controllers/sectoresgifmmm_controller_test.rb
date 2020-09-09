require 'test_helper'

class SectoresgifmmmControllerTest < ActionController::TestCase
  setup do
    skip
    @sectorgifmm = Sectorgifmm(:one)
  end

  test "should get index" do
    skip
    get :index
    assert_response :success
    assert_not_nil assigns(:sectorgifmm)
  end

  test "should get new" do
    skip
    get :new
    assert_response :success
  end

  test "should create sectorgifmm" do
    skip
    assert_difference('Sectorgifmm.count') do
      post :create, sectorgifmm: { created_at: @sectorgifmm.created_at, fechacreacion: @sectorgifmm.fechacreacion, fechadeshabilitacion: @sectorgifmm.fechadeshabilitacion, nombre: @sectorgifmm.nombre, observaciones: @sectorgifmm.observaciones, updated_at: @sectorgifmm.updated_at }
    end

    assert_redirected_to sectorgifmm_path(assigns(:sectorgifmm))
  end

  test "should show sectorgifmm" do
    skip
    get :show, id: @sectorgifmm
    assert_response :success
  end

  test "should get edit" do
    skip
    get :edit, id: @sectorgifmm
    assert_response :success
  end

  test "should update sectorgifmm" do
    skip
    patch :update, id: @sectorgifmm, sectorgifmm: { created_at: @sectorgifmm.created_at, fechacreacion: @sectorgifmm.fechacreacion, fechadeshabilitacion: @sectorgifmm.fechadeshabilitacion, nombre: @sectorgifmm.nombre, observaciones: @sectorgifmm.observaciones, updated_at: @sectorgifmm.updated_at }
    assert_redirected_to sectorgifmm_path(assigns(:sectorgifmm))
  end

  test "should destroy sectorgifmm" do
    skip
    assert_difference('Sectorgifmm.count', -1) do
      delete :destroy, id: @sectorgifmm
    end

    assert_redirected_to sectoresgifmmm_path
  end
end
