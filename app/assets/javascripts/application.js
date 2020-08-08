// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require sip/motor
//= require heb412_gen/motor
//= require mr519_gen/motor
//= require sivel2_gen/motor
//= require sivel2_gen/mapaosm
//= require sivel2_sjr/motor
//= require cor1440_gen/motor
//= require sal7711_web/motor
//= require chartkick
//= require_tree .

document.addEventListener('turbolinks:load', function() {
  var root
  root = typeof exports !== "undefined" && exports !== null ? 
    exports : window
  sip_prepara_eventos_comunes(root)

  // Antes de iniciar motor sivel2_gen ponemos este, para que se ejecute antes del incluido en ese motor
  $(document).on('change', 
    '[id^=caso_victima_attributes][id$=persona_attributes_anionac]', function(event) {

      root = typeof exports !== "undefined" && exports !== null ? 
        exports : window
      anionac = $(this).val()
      prefIdVic = $(this).attr('id').slice(0, -27)
      r = $("[id=" + prefIdVic + "_rangoedadactual_id]")
      prefIdPer = $(this).attr('id').slice(0, -8)
      ponerVariablesEdad(root)
      if (anionac != '')  {
        edadActual = edadDeFechaNac(prefIdPer, 
          root.anioactual, root.mesactual, 
          root.diaactual)
        if (edadActual != '') {
          rid = buscarRangoEdad(+edadActual); 
          r.val(rid)
        }
      } else {
        r.val(6)
      }
      r.prop('disabled', true)
    })


  heb412_gen_prepara_eventos_comunes(root)
  mr519_gen_prepara_eventos_comunes(root)
  sivel2_gen_prepara_eventos_comunes(root,'antecedentes/causas')
  sivel2_sjr_prepara_eventos_comunes(root)
  cor1440_gen_prepara_eventos_comunes(root)
  sal7711_gen_prepara_eventos_comunes(root)
  sivel2_sjr_prepara_eventos_unicos(root)

  //	$(document).on('click', 'input[data-enviarautomatico]', function(e) {
  //		e.preventDefault()
  //		sip_enviarautomatico_formulario($(e.target.form))
  //	})
  //En migracion, lista de sitios de salida se cálcula
  $(document).on('focusin', 
    'select[id^=caso_casosjr_attributes_][id$=id_salidam]', 
    function (e) {
      actualiza_ubicaciones($(this))
    })
  // En migracion, lista de sitios de llegada se cálcula
  $(document).on('focusin', 
    'select[id^=caso_casosjr_attributes_][id$=id_llegadam]', 
    function (e) {
      actualiza_ubicaciones($(this))
    }) 

  // Se recalcula tabla población si cambia fecha o listados de
  // personas o listado de casos
  $(document).on('change', 
    '[id=actividad_fecha_localizada]', 
    function (e) {
      jrs_recalcula_poblacion()
    }
  ) 
  $(document).on('change', 
    '[id^=actividad_asistencia_attributes]', 
    function (e) {
      jrs_recalcula_poblacion()
    }
  ) 
  $(document).on('change', 
    '[id^=actividad_actividad_casosjr_attributes]', 
    function (e) {
      jrs_recalcula_poblacion()
    }
  ) 

  $(document).on('cocoon:after-insert', '#migracion', 
    function (e) {
      $('[data-behaviour~=datepicker]').datepicker({
        format: 'yyyy-mm-dd',
        autoclose: true,
        todayHighlight: true,
        language: 'es',
      })
      $('.chosen-select').chosen()

      // Que el lugar de llegada en migración sea la ubicación de la oficina
      id_ofi = $('#caso_casosjr_attributes_oficina_id').val()
      opais = '[id^=caso_migracion_attributes_][id$=_llegada_pais_id]'
      odep = '[id^=caso_migracion_attributes_][id$=_llegada_departamento_id]'
      omun = '[id^=caso_migracion_attributes_][id$=_llegada_municipio_id]'
      oclas = '[id^=caso_migracion_attributes_][id$=_llegada_clase_id]'
      if(id_ofi != 1){
        $.getJSON("../../admin/oficinas/"+ id_ofi +".json", function(o){
          cu = 'chosen:updated'
          $(opais).val(o.pais_id).trigger(cu)
          $(odep).val(o.departamento_id).trigger(cu)
          $(omun).val(o.municipio_id).trigger(cu)
          $(oclas).val(o.clase_id).trigger(cu)
        });
      }

      e.stopPropagation()
    }
  ) 

  $(document).on('change', 
    '[id^=caso_migracion_attributes_][id$=_perfilmigracion_id]', 
    function (evento) {
      pid = evento.target.getAttribute('id').split('_')
      var pd = document.getElementById('caso_migracion_attributes_'+pid[3]+
        '_destino_pais_id').parentElement
      var dd = document.getElementById('caso_migracion_attributes_'+pid[3]+
        '_destino_departamento_id').parentElement
      var md = document.getElementById('caso_migracion_attributes_'+pid[3]+
        '_destino_municipio_id').parentElement
      var cd = document.getElementById('caso_migracion_attributes_'+pid[3]+
        '_destino_clase_id').parentElement
      var fd = document.getElementById('caso_migracion_attributes_'+pid[3]+
        '_fechaendestino').parentElement
      if (+evento.target.value != 2) {
        pd.style.display = 'none'
        dd.style.display = 'none'
        md.style.display = 'none'
        cd.style.display = 'none'
        fd.style.display = 'none'
      } else {
        pd.style.display = ''
        dd.style.display = ''
        md.style.display = ''
        cd.style.display = ''
        fd.style.display = ''
      }
    }
  )

  $(document).on('change', 
    '[id^=caso_migracion_attributes_][id$=_statusmigratorio_id]', 
    function (evento) {
      pid = evento.target.getAttribute('id').split('_')
      $('#camposPep').attr('id','camposPep' + pid[3])
      var ped = $('#camposPep'+ pid[3])
      var seleccionado = +evento.target.value.substring(event.target.selectionStart, event.target.selectionEnd)
      if (seleccionado != 1 && seleccionado != 5 && seleccionado != 6) {
        ped.attr("style", "display:none")
      } else {
        ped.attr("style", "display:block")
      }
    })

  $(document).on('change', 
    '[id^=caso_migracion_attributes_][id$=_pep]', 
    function (evento) {
      pid = evento.target.getAttribute('id').split('_')
      var ped = $('#caso_migracion_attributes_'+pid[3]+
        '_fechaPep').parents()[1]
      var tip = $('#caso_migracion_attributes_'+pid[3]+
        '_tipopep').parents()[1]
      var seleccionado = evento.target.value.substring(event.target.selectionStart, event.target.selectionEnd)
      if (seleccionado != 1) {
        ped.style.display = 'none'
        tip.style.display = 'none'
      } else {
        ped.style.display = ''
        tip.style.display = ''
      }
    })

  $(document).on('change', 
    '[id^=caso_migracion_attributes_][id$=_proteccion_id]', 
    function (evento) {
      pid = evento.target.getAttribute('id').split('_')
      var seleccionado = +evento.target.value.substring(event.target.selectionStart, event.target.selectionEnd)
      var ped = $('#caso_migracion_attributes_'+pid[3]+
        '_fechaNpi').parents()[1]
      if (seleccionado != 8) {
        ped.style.display = 'none'
      } else {
        ped.style.display = ''
      }
    })

  $(document).on('change', '#persona_id_pais',
    function (evento) {
      pais = $('#persona_id_pais').val()
      if (!$('#persona_nacionalde').val()){
        $('#persona_nacionalde').val(pais)
      }
    })
})

