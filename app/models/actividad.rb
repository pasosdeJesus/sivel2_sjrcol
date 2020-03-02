# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Actividad
        extend ActiveSupport::Concern

        included do
          include Mr519Gen::Modelo 
          include Sip::Localizacion
          @current_usuario = -1
          attr_accessor :current_usuario

          belongs_to :oficina, class_name: 'Sip::Oficina', 
            foreign_key: 'oficina_id', validate: true, optional: true

          belongs_to :responsable, 
            class_name: '::Usuario', 
            foreign_key: 'usuario_id', validate: true, optional: true

          has_and_belongs_to_many :actividadpf, 
            class_name: 'Cor1440Gen::Actividadpf',
            foreign_key: 'actividad_id',
            association_foreign_key: 'actividadpf_id',
            join_table: 'cor1440_gen_actividad_actividadpf'

          has_and_belongs_to_many :actividadtipo, 
            class_name: 'Cor1440Gen::Actividadtipo',
            foreign_key: 'actividad_id',
            association_foreign_key: 'actividadtipo_id',
            join_table: 'cor1440_gen_actividad_actividadtipo'

          has_and_belongs_to_many :actorsocial, 
            class_name: 'Sip::Actorsocial',
            foreign_key: 'actividad_id',
            association_foreign_key: 'actorsocial_id',
            join_table: 'cor1440_gen_actividad_actorsocial'

          has_and_belongs_to_many :respuestafor, 
            class_name: 'Mr519Gen::Respuestafor',
            foreign_key: 'actividad_id',
            association_foreign_key: 'respuestafor_id', 
            join_table: 'cor1440_gen_actividad_respuestafor'
          accepts_nested_attributes_for :respuestafor, 
            allow_destroy: true, reject_if: :all_blank

          has_and_belongs_to_many :proyectofinanciero, 
            class_name: 'Cor1440Gen::Proyectofinanciero',
            foreign_key: 'actividad_id',
            association_foreign_key: 'proyectofinanciero_id',
            join_table: 'cor1440_gen_actividad_proyectofinanciero'

          has_and_belongs_to_many :usuario, 
            class_name: 'Usuario',
            foreign_key: 'actividad_id',
            association_foreign_key: 'usuario_id',
            join_table: 'cor1440_gen_actividad_usuario'

          has_many :actividad_proyecto, dependent: :delete_all,
            class_name: 'Cor1440Gen::ActividadProyecto',
            foreign_key: 'actividad_id'

          has_many :actividadareas_actividad, dependent: :delete_all,
            class_name: 'Cor1440Gen::ActividadareasActividad',
            foreign_key: 'actividad_id'

          has_many :actividadareas, through: :actividadareas_actividad,
            class_name: 'Cor1440Gen::Actividadarea'


          has_many :actividad_rangoedadac, foreign_key: "actividad_id", 
            dependent: :delete_all, 
            class_name: 'Cor1440Gen::ActividadRangoedadac'
         
          has_many :actividad_sip_anexo, foreign_key: "actividad_id", 
            validate: true, dependent: :destroy, 
            class_name: 'Cor1440Gen::ActividadSipAnexo',
            inverse_of: :actividad
          accepts_nested_attributes_for :actividad_sip_anexo, 
            allow_destroy: true, reject_if: :all_blank
 
          has_many :actividad_valorcampotind, dependent: :delete_all,
            class_name: 'Cor1440Gen::ActividadValorcampotind',
            foreign_key: 'actividad_id', validate: true
          accepts_nested_attributes_for :actividad_valorcampotind,
            allow_destroy: true, reject_if: :all_blank

          has_many :asistencia, dependent: :delete_all,
            class_name: 'Cor1440Gen::Asistencia',
            foreign_key: 'actividad_id'

          has_many :persona, through: :asistencia, class_name: 'Sip::Persona'
          accepts_nested_attributes_for :persona, reject_if: :all_blank
          accepts_nested_attributes_for :asistencia,
            allow_destroy: true, reject_if: :all_blank

          has_many :proyecto, through: :actividad_proyecto,
            class_name: 'Cor1440Gen::Proyecto'
         
          has_many :rangoedadac, through: :actividad_rangoedadac,
            class_name: 'Cor1440Gen::Rangoedadac'
          accepts_nested_attributes_for :rangoedadac,  reject_if: :all_blank
          accepts_nested_attributes_for :actividad_rangoedadac, 
            allow_destroy: true, reject_if: :all_blank

          has_many :sip_anexo, through: :actividad_sip_anexo,
            class_name: 'Sip::Anexo'
          accepts_nested_attributes_for :sip_anexo, 
            reject_if: :all_blank

          has_many :valorcampotind, through: :actividad_valorcampotind,
            class_name: 'Cor1440Gen::Valorcampotind'
          accepts_nested_attributes_for :valorcampotind,  reject_if: :all_blank

          campofecha_localizado :fecha

          validates_presence_of :oficina
          validates :fecha, presence: true, allow_blank: false
          validates :nombre, presence: true, allow_blank: false, 
            length: { maximum: 500 } 
          validates :objetivo, length: { maximum: 5000 } 
          validates :resultado, length: { maximum: 5000 } 
          validates :observaciones, length: { maximum: 5000 } 

          validate :rol_usuario
          def rol_usuario
            if (oficina_id && responsable && responsable.oficina_id &&
                 responsable.oficina_id != oficina_id) then
              errors.add(:oficina, "Responsable y oficina deben coincidir")
            end
          end

          validate :fecha_concuerda_corresponsables_habilitados
          def fecha_concuerda_corresponsables_habilitados
            if (fecha && usuario && usuario.length > 0) then
              usuario.each do |u|
                if u.fechacreacion > fecha
                  errors.add(:usuario, "Corresponsable #{u.presenta_nombre} " +
                             " tiene fecha de creación posterior a la actividad")
                end
                if u.fechadeshabilitacion && u.fechadeshabilitacion < fecha
                  errors.add(:usuario, "Corresponsable #{u.presenta_nombre} " +
                             " tiene fecha de deshabilitacion anterior " +
                             "a la actividad")
                end
              end
            end
          end

          validate :fecha_concuerda_responsable_habilitado
          def fecha_concuerda_responsable_habilitado
            if (fecha && responsable) then
              if responsable.fechacreacion > fecha
                errors.add(:responsable, "Responsable tiene " +
                           " fecha de creación posterior a la actividad")
              end
              if responsable.fechadeshabilitacion && 
                responsable.fechadeshabilitacion < fecha
                errors.add(:responsable, "Responsable tiene " +
                           " fecha de deshabilitacion anterior a la actividad")
              end
            end
          end

          def presenta_actividad(atr)
            case atr.to_s
            when /anexo_[0-9]_desc/
              i = atr[6].to_i
              if sip_anexo.count >= i
                sip_anexo.order(:id)[i-1].descripcion
              else 
                ''
              end

            when Cor1440Gen::Actividad.human_attribute_name(
              :actividadareas).downcase.gsub(' ', '_')
              actividadareas.inject('') { |memo, r| 
                memo == '' ? r.presenta_nombre : '; ' + r.presenta_nombre
              }

            when Cor1440Gen::Actividad.human_attribute_name(
              :actividadpf).downcase.gsub(' ', '_')
              actividadpf.inject('') { |memo, r| 
                memo == '' ? r.presenta_nombre : '; ' + r.presenta_nombre
                #memo += '; ' if memo != ''
                #memo += r.nombrecorto + ' ' + r.titulo
                #memo
              }

            when 'actualizacion'
              updated_at
              
            when 'campos_dinamicos'
              if !respuestafor || respuestafor.count == 0
                ""
              else
                respuestafor.inject('') do |memorf, rf|
                    seprf = memorf == '' ? '' : '. '
                    vc = rf.valorcampo.inject('') { |memo, v|
                      sep = memo == '' ? '' : ';'
                      if v.campo
                        memo + sep + v.campo.nombre + ": " + v.valor
                      else
                        memo
                      end
                    }
                    memorf + seprf + rf.formulario.nombreinterno + 
                      "[" + vc + "]"
                end
              end
            when 'creacion'
              created_at

            when 'corresponsables'
              usuario.inject('') { |memo, r| 
                memo == '' ? r.presenta_nombre : memo + '; ' + r.presenta_nombre
              }

            when 'objetivo_convenio_financiero'
              actividadpf.inject('') { |memo, a|
                sep = memo == '' ? '' : ';'
                if a.resultadopf && a.resultadopf.objetivopf
                  memo + sep + a.resultadopf.objetivopf.numero
                else
                  memo
                end
              }

            when 'ubicacion'
              lugar           
            
            when 'poblacion'
              actividad_rangoedadac.inject(0) { |memo, r| 
                memo += r.ml ? r.ml : 0
                memo += r.mr ? r.mr : 0
                memo += r.fl ? r.fl : 0
                memo += r.fr ? r.fr : 0
                memo
              }

            when 'poblacion_hombres_l'
              actividad_rangoedadac.inject(0) { |memo, r| 
                memo += r.ml ? r.ml : 0
                memo
              }
 
           
            when 'poblacion_hombres_r'
              actividad_rangoedadac.inject(0) { |memo, r| 
                memo += r.mr ? r.mr : 0
                memo
              }

            when 'poblacion_hombres'
              actividad_rangoedadac.inject(0) { |memo, r| 
                memo += r.mr ? r.mr : 0
                memo += r.ml ? r.ml : 0
                memo
              }

            when 'poblacion_mujeres_l'
              actividad_rangoedadac.inject(0) { |memo, r| 
                memo += r.fl ? r.fl : 0
                memo
              }
            
            when 'poblacion_mujeres_r'
              actividad_rangoedadac.inject(0) { |memo, r| 
                memo += r.fr ? r.fr : 0
                memo
              }

            when 'poblacion_mujeres'
              actividad_rangoedadac.inject(0) { |memo, r| 
                memo += r.fl ? r.fl : 0
                memo += r.fr ? r.fr : 0
                memo
              }

            when 'poblacion_sin_sexo'
              actividad_rangoedadac.inject(0) { |memo, r| 
                memo += r.s ? r.s : 0
                memo
              }
            when /poblacion_hombres_l_g[0-9]*/
              g = atr[21..-1].to_i
              actividad_rangoedadac.where(rangoedadac_id: g).
                  inject(0) { |memo, r| 
                memo += r.ml ? r.ml : 0
                memo
              }
           
            when /poblacion_hombres_r_g[0-9]*/
              g = atr[21..-1].to_i
              actividad_rangoedadac.where(rangoedadac_id: g).
                inject(0) { |memo, r| 
                memo += r.mr ? r.mr : 0
                memo
              }

            when /poblacion_mujeres_l_g[0-9]*/
              g = atr[21..-1].to_i
              actividad_rangoedadac.where(rangoedadac_id: g).
                inject(0) { |memo, r| 
                memo += r.fl ? r.fl : 0
                memo
              }

            when /poblacion_mujeres_r_g[0-9]*/
              g = atr[21..-1].to_i
              actividad_rangoedadac.where(rangoedadac_id: g).
                inject(0) { |memo, r| 
                memo += r.fr ? r.fr : 0
                memo
              }


            when Cor1440Gen::Actividad.human_attribute_name(
              :proyectos).downcase.gsub(' ', '_')
              proyecto.inject('') { |memo, r| 
                memo == '' ? r.presenta_nombre : '; ' + r.presenta_nombre
                #memo == '' ? r.nombre : '; ' + r.nombre
              }

            when Cor1440Gen::Actividad.human_attribute_name(
              :proyectofinanciero).downcase.gsub(' ', '_')
              proyectofinanciero.inject('') { |memo, r| 
                memo == '' ? r.presenta_nombre : '; ' + r.presenta_nombre
                #memo == '' ? r.nombre : '; ' + r.nombre
              }

            else
              presenta_gen(atr)
            end
          end

          def presenta(atr)
            presenta_actividad(atr)
          end

          scope :filtro_actividadpf, lambda { |ida|
            where('cor1440_gen_actividad.id IN (SELECT actividad_id FROM ' +
                  'cor1440_gen_actividad_actividadpf WHERE ' +
                  'actividadpf_id = ?)',ida)
          }

          scope :filtro_actividadareas, lambda { |ida|
            where('cor1440_gen_actividad.id IN (SELECT actividad_id FROM ' +
                  'cor1440_gen_actividadareas_actividad WHERE ' +
                  'actividadarea_id = ?)',ida)
          }

          scope :filtro_fechaini, lambda { |f|
            where('fecha >= ?', f)
            # El control de fecha HTML estándar retorna la fecha
            # en formato yyyy-mm-dd siempre
          }

          scope :filtro_fechafin, lambda { |f|
            where('fecha <= ?', f)
          }

         scope :filtro_lugar, lambda { |l|
            where("unaccent(lugar) ILIKE '%' || unaccent(?) || '%'", l)
          }
 
          scope :filtro_nombre, lambda { |n|
            where("unaccent(nombre) ILIKE '%' || unaccent(?) || '%'", n)
          }
 
          scope :filtro_objetivo, lambda { |o|
            where("unaccent(objetivo) ILIKE '%' || unaccent(?) || '%'", o)
          }
 
          scope :filtro_observaciones, lambda { |o|
            where("unaccent(observaciones) ILIKE '%' || unaccent(?) || '%'", 
                  o)
          }
 
          scope :filtro_oficina, lambda { |oid|
            where(oficina_id: oid)
          }

          scope :filtro_proyectos, lambda { |idp|
            where('cor1440_gen_actividad.id IN (SELECT actividad_id FROM ' +
                  'cor1440_gen_actividad_proyecto WHERE ' +
                  'proyecto_id = ?)',idp)
          }

          scope :filtro_proyectofinanciero, lambda { |pid|
            where('cor1440_gen_actividad.id IN (SELECT actividad_id FROM ' +
                  'cor1440_gen_actividad_proyectofinanciero WHERE ' +
                  'proyectofinanciero_id = ?)',pid)
          }

          scope :filtro_responsable, lambda { |uid|
            where(usuario_id: uid)
          }

          scope :filtro_resultado, lambda { |r|
            where("unaccent(resultado) ILIKE '%' || unaccent(?) || '%'", r)
          }
 
        end
      end
    end
  end
end

