require 'test_helper'

module Sivel2Sjr
  module Admin

    class AccionesjuridicasControllerTest < ActionController::TestCase
      setup do
        skip
        @accionjuridica = Accionjuridica(:one)
      end

      test "should get index" do
        skip
        get :index
        assert_response :success
        assert_not_nil assigns(:accionjuridica)
      end

      test "should get new" do
        skip
        get :new
        assert_response :success
      end

      test "should create accionjuridica" do
        skip
        assert_difference('Accionjuridica.count') do
          post :create, accionjuridica: { created_at: @accionjuridica.created_at, fechacreacion: @accionjuridica.fechacreacion, fechadeshabilitacion: @accionjuridica.fechadeshabilitacion, nombre: @accionjuridica.nombre, observaciones: @accionjuridica.observaciones, updated_at: @accionjuridica.updated_at }
        end

        assert_redirected_to accionjuridica_path(assigns(:accionjuridica))
      end

      test "should show accionjuridica" do
        skip
        get :show, id: @accionjuridica
        assert_response :success
      end

      test "should get edit" do
        skip
        get :edit, id: @accionjuridica
        assert_response :success
      end

      test "should update accionjuridica" do
        skip
        patch :update, id: @accionjuridica, accionjuridica: { created_at: @accionjuridica.created_at, fechacreacion: @accionjuridica.fechacreacion, fechadeshabilitacion: @accionjuridica.fechadeshabilitacion, nombre: @accionjuridica.nombre, observaciones: @accionjuridica.observaciones, updated_at: @accionjuridica.updated_at }
        assert_redirected_to accionjuridica_path(assigns(:accionjuridica))
      end

      test "should destroy accionjuridica" do
        skip
        assert_difference('Accionjuridica.count', -1) do
          delete :destroy, id: @accionjuridica
        end

        assert_redirected_to accionjuridicaes_path
      end
    end
  end
end

