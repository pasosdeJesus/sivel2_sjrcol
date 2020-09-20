
// En migracion actualiza tras cambiar salida
$(document).on('focusin', 
  'select[id^=caso_casosjr_attributes_][id$=id_salidam]', 
  function (e) {
    actualiza_ubicaciones($(this))
  }
)

// En migracion, lista de sitios de llegada se cálcula
$(document).on('focusin', 
  'select[id^=caso_casosjr_attributes_][id$=id_llegadam]', 
  function (e) {
    actualiza_ubicaciones($(this))
  }
)


// Se recalcula tabla población si cambia fecha
// Otros casos de cambio en listados de casos y asistencia ya
// cubiertos en el motor de sivel2_sjr
$(document).on('change', 
  '[id=actividad_fecha_localizada]', 
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
  }
)

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
  }
)

$(document).on('change', 
  '[id^=caso_migracion_attributes_][id$=_proteccion_id]', 
  function (evento) {
    pid = evento.target.getAttribute('id').split('_')
    var seleccionado = +evento.target.value //.substring(event.target.selectionStart, event.target.selectionEnd)
    var sec_refugio = $('#caso_migracion_attributes_'+pid[3]+
      '_fechaNpi').closest('.sec_refugio')[0]
    var otra = $('#caso_migracion_attributes_'+pid[3]+
      '_otronpi').parents()[1]
    if (seleccionado != 8 && seleccionado != 1) { // Refugiado o solicitante
      sec_refugio.style.display = 'none'
    } else {
      sec_refugio.style.display = ''
    }
    if (seleccionado != 7) {
      otra.style.display = 'none'
    } else {
      otra.style.display = ''
    }
  }
)

$(document).on('change', '#persona_id_pais',
  function (evento) {
    pais = $('#persona_id_pais').val()
    if (!$('#persona_nacionalde').val()){
      $('#persona_nacionalde').val(pais)
    }
  }
)

