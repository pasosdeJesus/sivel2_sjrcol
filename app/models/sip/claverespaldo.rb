class Sip::Claverespaldo < ActiveRecord::Base
  include Sip::Modelo

  validates :created_at, presence: true
  validates :clave, presence: true, length: { maximum: 2047 }

end
