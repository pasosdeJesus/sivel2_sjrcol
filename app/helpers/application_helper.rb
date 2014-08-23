module ApplicationHelper
=begin
def resource_name
    :usuario
  end

  def resource
    @resource ||= Usuario.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:usuario]
  end
=end
end
