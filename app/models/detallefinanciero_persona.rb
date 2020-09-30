class DetallefinancieroPersona < ActiveRecord::Base

  belongs_to :detallefinanciero, validate: true

  belongs_to :persona, foreign_key: 'persona_id',
    class_name: 'Sip::Persona', optional: true

end
