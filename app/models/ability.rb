# encoding: UTF-8

class Ability < Sivel2Sjr::Ability

  BASICAS_PROPIAS =  [
    ['Sivel2Sjr', 'ayudaestado'], 
    ['Sivel2Sjr', 'declaroante'], 
    ['Sivel2Sjr', 'derecho'], 
    ['Sivel2Sjr', 'motivosjr'], 
    ['Sivel2Sjr', 'progestado'], 
    ['Sivel2Sjr', 'regimensalud']
  ]
  
  @@tablasbasicas = Sip::Ability::BASICAS_PROPIAS + 
    Cor1440Gen::Ability::BASICAS_PROPIAS +
    Sal7711Gen::Ability::BASICAS_PROPIAS + 
    Sivel2Gen::Ability::BASICAS_PROPIAS + 
    Sivel2Sjr::Ability::BASICAS_PROPIAS + 
    BASICAS_PROPIAS - [
      ['Sivel2Gen', 'filiacion'],
      ['Sivel2Gen', 'frontera'],
      ['Sivel2Gen', 'iglesia'],
      ['Sivel2Gen', 'intervalo'],
      ['Sivel2Gen', 'organizacion'],
      ['Sivel2Gen', 'pconsolidado'],
      ['Sivel2Gen', 'region'],
      ['Sivel2Gen', 'sectorsocial'],
      ['Sivel2Gen', 'vinculoestado'],
      ['Sivel2Sjr', 'idioma']
  ]

  @@basicas_id_noauto = Sip::Ability::BASICAS_ID_NOAUTO +
    Sivel2Gen::Ability::BASICAS_ID_NOAUTO 

  @@nobasicas_indice_seq_con_id = Sip::Ability::NOBASICAS_INDSEQID +
    Sivel2Gen::Ability::NOBASICAS_INDSEQID 

  @@tablasbasicas_prio = Sip::Ability::BASICAS_PRIO +
    Sivel2Gen::Ability::BASICAS_PRIO +
    Sivel2Sjr::Ability::BASICAS_PRIO

  def initialize(usuario)
    super(usuario)
    if usuario && usuario.rol then
        can :read, Sal7711Gen::Articulo
    end
  end

end
