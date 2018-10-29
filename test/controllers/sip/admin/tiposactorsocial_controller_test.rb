require 'byebug'
require 'test_helper'
require_relative '../../../models/sip/tipoactorsocial_test'

module Sip
  module Admin

    class TiposactorsocialControllerTest < ActionController::TestCase
      include Engine.routes.url_helpers
      include Devise::Test::IntegrationHelpers 
      include Rails.application.routes.url_helpers


      setup do
        @tipoactorsocial = Sip::Tipoactorsocial.create(
          Sip::TipoactorsocialTest::PRUEBA_TIPOACTORSOCIAL)
        #byebug
        #@controller = Sip::Admin::TiposactorsocialController
      end

      test "should get index" do
        skip
        get tiposactorsocial_url
        assert_response :success
        assert_not_nil assigns(:tipoactorsocial)
      end

      test "should get new" do
        skip
        get :new
        assert_response :success
      end

      test "should create tipoactorsocial" do
        skip
        assert_difference('Tipoactorsocial.count') do
          post :create, tipoactorsocial: { created_at: @tipoactorsocial.created_at, fechacreacion: @tipoactorsocial.fechacreacion, fechadeshabilitacion: @tipoactorsocial.fechadeshabilitacion, nombre: @tipoactorsocial.nombre, observaciones: @tipoactorsocial.observaciones, updated_at: @tipoactorsocial.updated_at }
        end

        assert_redirected_to tipoactorsocial_path(assigns(:tipoactorsocial))
      end

      test "should show tipoactorsocial" do
        skip
        get :show, id: @tipoactorsocial
        assert_response :success
      end

      test "should get edit" do
        skip
        get :edit, id: @tipoactorsocial
        assert_response :success
      end

      test "should update tipoactorsocial" do
        skip
        patch :update, id: @tipoactorsocial, tipoactorsocial: { created_at: @tipoactorsocial.created_at, fechacreacion: @tipoactorsocial.fechacreacion, fechadeshabilitacion: @tipoactorsocial.fechadeshabilitacion, nombre: @tipoactorsocial.nombre, observaciones: @tipoactorsocial.observaciones, updated_at: @tipoactorsocial.updated_at }
        assert_redirected_to tipoactorsocial_path(assigns(:tipoactorsocial))
      end

      test "should destroy tipoactorsocial" do
        skip
        assert_difference('Tipoactorsocial.count', -1) do
          delete :destroy, id: @tipoactorsocial
        end

        assert_redirected_to tiposactorsocial_path
      end
    end

  end
end
