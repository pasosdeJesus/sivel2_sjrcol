module ApplicationHelper
  def self.included klass
    klass.class_eval do
      include Sal7711Gen::ApplicationHelper
      include Sivel2Gen::ApplicationHelper
    end
  end
end
