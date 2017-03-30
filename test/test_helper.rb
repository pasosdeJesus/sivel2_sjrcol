# encoding: utf-8

ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start
require_relative '../config/environment'
require 'rails/test_help'

require "minitest/rails/capybara"
require "capybara/rails"
require "capybara/poltergeist"
Capybara.javascript_driver = :poltergeist


# Usuario para ingresar y hacer pruebas
PRUEBA_USUARIO = {
  nusuario: "admin",
  password: "sjrven123",
  nombre: "admin",
  descripcion: "admin",
  rol: 1,
  idioma: "es_CO",
  email: "usuario1@localhost",
  encrypted_password: '$2a$10$uMAciEcJuUXDnpelfSH6He7BxW0yBeq6VMemlWc5xEl6NZRDYVA3G',
  sign_in_count: 0,
  fechacreacion: "2014-08-05",
  fechadeshabilitacion: nil,
  oficina_id: nil
}

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
  
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  # Ver http://www.rubytutorial.io/how-to-test-an-autocomplete-with-rails/
  include Capybara::DSL

  require 'capybara/poltergeist'

  Capybara.javascript_driver = :poltergeist

  def teardown
    Capybara.current_driver = nil
  end
end

class ActiveRecord::Base
  # Ver https://gist.github.com/mperham/3049152
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || ConnectionPool::Wrapper.new(:size => 1) { retrieve_connection }
  end
end
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection

