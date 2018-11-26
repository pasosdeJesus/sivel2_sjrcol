require 'test_helper'
require_relative '../../../models/sip/lineaactorsocial_test'

module Sip
  module Admin

    class LineasactorsocialControllerTest < ActionController::TestCase
      include Engine.routes.url_helpers
      include Devise::Test::IntegrationHelpers 
      include Rails.application.routes.url_helpers


      setup do
        @lineaactorsocial = Sip::Lineaactorsocial.create(
          Sip::LineaactorsocialTest::PRUEBA_LINEAACTORSOCIAL)
        #byebug
        #@controller = Sip::Admin::LineasactorsocialController
      end

      test "should get index" do
        skip
        get lineasactorsocial_url
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

        assert_redirected_to lineasactorsocial_path
      end
    end

  end
end
