
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

    // Poner ids para expandir/contraer ubicaciones
    // Debe estar en sincronia con
    // app/views/sip/ubicacionpre/_dos_filas_confecha
    control = $('#ubicacionpre-salida-0').parent()
    cocoonid = control.find('[id$=fechasalida]').attr('id').split('_')[3]

    console.log(cocoonid);

    ['salida', 'llegada', 'destino'].forEach(function (v, i) {
      control = $('#ubicacionpre-' + v + '-0').parent()
      control.find('#ubicacionpre-' + v + '-0').attr('id', 
        'ubicacionpre-' + v + '-'+ cocoonid)
      control.find('#resto-' + v + '-0').attr('id', 
        'resto-' + v + '-'+ cocoonid)
      control.find('#restocp-' + v + '-0').attr('id', 
        'restocp-' + v + '-'+ cocoonid)
      b = control.find('button[data-target$=' + v + '-0]')
      console.log(b.attr('data-target'))
      b.attr('data-target', 
        '#resto-' + v + '-' + cocoonid + ',#restocp-' + v + '-' + cocoonid)
    })

    e.stopPropagation()
  }
)

$(document).on('change', 
  '[id^=caso_migracion_attributes_][id$=_perfilmigracion_id]', 
  function (evento) {
    pid = evento.target.getAttribute('id').split('_')
    if (+evento.target.value == 2) {
      d = 'block'
    } else {
      d = 'none'
    }
    $(evento.target).closest('.controls').
      find('[id^=ubicacionpre-destino]').css('display', d)
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

function maneja_evento_busca_ubicacionpre_lugar(e) {
  root = window
  ubicacionpre = $(this).closest('.ubicacionpre')
  if (ubicacionpre.length != 1) {
    alert('No se encontró ubicacionpre para ' + 
      $(this).attr('id'))
  }

  pais = ubicacionpre.find('[id$=pais_id]').val()
  dep = ubicacionpre.find('[id$=departamento_id]').val()
  mun = ubicacionpre.find('[id$=municipio_id]').val()
  clas = ubicacionpre.find('[id$=clase_id]').val()
  ubi = [pais, dep, mun, clas]
  busca_ubicacionpre_lugar($(this), ubi)
}


$(document).on('focusin', 
  'input[id^=caso_migracion_attributes][id$=_salida_lugar]', 
  maneja_evento_busca_ubicacionpre_lugar
)

$(document).on('focusin', 
  'input[id^=caso_migracion_attributes][id$=_llegada_lugar]', 
  maneja_evento_busca_ubicacionpre_lugar
)

$(document).on('focusin', 
  'input[id^=caso_migracion_attributes][id$=_destino_lugar]', 
  maneja_evento_busca_ubicacionpre_lugar
)

function busca_ubicacionpre_lugar(s, ubi) {
  root = window
  sip_arregla_puntomontaje(root)
  cnom = s.attr('id')
  v = $("#" + cnom).data('autocompleta')
  if (v != 1 && v != "no"){
    $("#" + cnom).data('autocompleta', 1)
    // Buscamos un div con clase div_ubicacionpre dentro del cual
    // están tanto el campo ubicacionpre_id como el campo
    // ubicacionpre_texto 
    ubipre = s.closest('.div_ubicacionpre')
    if (typeof ubipre == 'undefined'){
      alert('No se ubico .div_ubicacionpre')
      return
    }
    if ($(ubipre).find("[id$='ubicacionpre_id']").length != 1) {
      alert('Dentro de .div_ubicacionpre no se ubicó ubicacionpre_id')
      return
    }
    if ($(ubipre).find("[id$='_lugar']").length != 1) {
      alert('Dentro de .div_ubicacionpre no se ubicó ubicacionpre_texto')
      return
    }
    $("#" + cnom).autocomplete({
      source: root.puntomontaje + "ubicacionespre_lugar.json" + '?pais=' + ubi[0]+ '&dep=' + ubi[1] + '&mun=' + ubi[2] + '&clas=' + ubi[3],
      cacheLength: 0,
      minLength: 2,
      select: function( event, ui ){ 
        if (ui.item){ 
          autocompleta_ubicacionpre_lugar(ui.item.clase_id, ui.item.tsitio_id, ui.item.lugar, ui.item.sitio, ui.item.latitud, ui.item.longitud, ubipre, root)
          event.stopPropagation()
          event.preventDefault()
        }
      }
    })
  }
  return
}

function autocompleta_ubicacionpre_lugar(clase_id, tsit, lug, sit, lat, lon, ubipre, root){
  sip_arregla_puntomontaje(root)
  ubipre.parent().find('[id$=_clase_id]').val(clase_id).trigger('chosen:updated')
  ubipre.find('[id$=_lugar]').val(lug)
  ubipre.find('[id$=_sitio]').val(sit)
  ubipre.find('[id$=_latitud]').val(lat)
  ubipre.find('[id$=_longitud]').val(lon)
  ubipre.find('[id$=_tsitio_id]').val(tsit).trigger('chosen:updated')
  $(document).trigger("sip:autocompletada-ubicacionpre")
  return
}
//Salida
$(document).on('change', 
  '[id^=caso_migracion_attributes_][id$=salida_pais_id]', 
  function (evento) {
    fija_coordenadas(evento, "salida", $(this), "paises")
})
$(document).on('change', 
  '[id^=caso_migracion_attributes_][id$=salida_departamento_id]', 
  function (evento) {
    if($(this).val()==""){
      pid = evento.target.getAttribute('id').split('_')
      pais = $('#caso_migracion_attributes_' + pid[3] + '_' + campoubi + '_pais_id')
      fija_coordenadas(evento, "salida", pais, "paises")
    }else{
      deshabilita_otros_sinohaymun(evento, "salida")
      fija_coordenadas(evento, "salida", $(this), "departamentos")
    }
})
$(document).on('change', 
  '[id^=caso_migracion_attributes_][id$=salida_municipio_id]', 
  function (evento) {
    if($(this).val()==""){
      deshabilita_otros_sinohaymun(evento, "salida")
      pid = evento.target.getAttribute('id').split('_')
      dep = $('#caso_migracion_attributes_' + pid[3] + '_' + campoubi + '_departamento_id')
      fija_coordenadas(evento, "salida", dep, "departamentos")
    }else{
      habilita_otros_sihaymun(evento, 1, "salida")
      fija_coordenadas(evento, "salida", $(this), "municipios")
    }
})
$(document).on('change', 
  '[id^=caso_migracion_attributes_][id$=salida_clase_id]', 
  function (evento) {
    if($(this).val()==""){
      pid = evento.target.getAttribute('id').split('_')
      mun = $('#caso_migracion_attributes_' + pid[3] + '_' + campoubi + '_municipio_id')
      fija_coordenadas(evento, "salida", mun, "municipios")
    }else{
      habilita_otros_sihaymun(evento, 1, "salida")
      fija_coordenadas(evento, "salida", $(this), "clases")
    }
})
$(document).on('change', 
  '[id^=caso_migracion_attributes_][id$=salida_lugar]', 
  function (evento) {
    habilita_otros_sihaymun(evento, 2, "salida")
})

//Llegada
$(document).on('change', 
  '[id^=caso_migracion_attributes_][id$=llegada_pais_id]', 
  function (evento) {
    fija_coordenadas(evento, "llegada", $(this), "paises")
})
$(document).on('change', 
  '[id^=caso_migracion_attributes_][id$=llegada_departamento_id]', 
  function (evento) {
    if($(this).val()==""){
      pid = evento.target.getAttribute('id').split('_')
      pais = $('#caso_migracion_attributes_' + pid[3] + '_' + campoubi + '_pais_id')
      fija_coordenadas(evento, "llegada", pais, "paises")
    }else{
      deshabilita_otros_sinohaymun(evento, "llegada")
      fija_coordenadas(evento, "llegada", $(this), "departamentos")
    }
})
$(document).on('change', 
  '[id^=caso_migracion_attributes_][id$=llegada_municipio_id]', 
  function (evento) {
    if($(this).val()==""){
      deshabilita_otros_sinohaymun(evento, "llegada")
      pid = evento.target.getAttribute('id').split('_')
      dep = $('#caso_migracion_attributes_' + pid[3] + '_' + campoubi + '_departamento_id')
      fija_coordenadas(evento, "llegada", dep, "departamentos")
    }else{
      habilita_otros_sihaymun(evento, 1, "llegada")
      fija_coordenadas(evento, "llegada", $(this), "municipios")
    }
})
$(document).on('change', 
  '[id^=caso_migracion_attributes_][id$=llegada_clase_id]', 
  function (evento) {
    if($(this).val()==""){
      pid = evento.target.getAttribute('id').split('_')
      mun = $('#caso_migracion_attributes_' + pid[3] + '_' + campoubi + '_municipio_id')
      fija_coordenadas(evento, "llegada", mun, "municipios")
    }else{
      habilita_otros_sihaymun(evento, 1, "llegada")
      fija_coordenadas(evento, "llegada", $(this), "clases")
    }
})
$(document).on('change', 
  '[id^=caso_migracion_attributes_][id$=llegada_lugar]', 
  function (evento) {
    habilita_otros_sihaymun(evento, 2, "llegada")
})

//Destino
$(document).on('change', 
  '[id^=caso_migracion_attributes_][id$=destino_pais_id]', 
  function (evento) {
    fija_coordenadas(evento, "destino", $(this), "paises")
})
$(document).on('change', 
  '[id^=caso_migracion_attributes_][id$=destino_departamento_id]', 
  function (evento) {
    if($(this).val()==""){
      pid = evento.target.getAttribute('id').split('_')
      pais = $('#caso_migracion_attributes_' + pid[3] + '_' + campoubi + '_pais_id')
      fija_coordenadas(evento, "destino", pais, "paises")
    }else{
      deshabilita_otros_sinohaymun(evento, "destino")
      fija_coordenadas(evento, "destino", $(this), "departamentos")
    }
})
$(document).on('change', 
  '[id^=caso_migracion_attributes_][id$=destino_municipio_id]', 
  function (evento) {
    if($(this).val()==""){
      deshabilita_otros_sinohaymun(evento, "destino")
      pid = evento.target.getAttribute('id').split('_')
      dep = $('#caso_migracion_attributes_' + pid[3] + '_' + campoubi + '_departamento_id')
      fija_coordenadas(evento, "destino", dep, "departamentos")
    }else{
      habilita_otros_sihaymun(evento, 1, "destino")
      fija_coordenadas(evento, "destino", $(this), "municipios")
    }
})
$(document).on('change', 
  '[id^=caso_migracion_attributes_][id$=destino_clase_id]', 
  function (evento) {
    if($(this).val()==""){
      pid = evento.target.getAttribute('id').split('_')
      mun = $('#caso_migracion_attributes_' + pid[3] + '_' + campoubi + '_municipio_id')
      fija_coordenadas(evento, "destino", mun, "municipios")
    }else{
      habilita_otros_sihaymun(evento, 1, "destino")
      fija_coordenadas(evento, "destino", $(this), "clases")
    }
})
$(document).on('change', 
  '[id^=caso_migracion_attributes_][id$=destino_lugar]', 
  function (evento) {
    habilita_otros_sihaymun(evento, 2, "destino")
})

// Funciones
function fija_coordenadas(e, campoubi, elemento, ubi_plural){
  pid = e.target.getAttribute('id').split('_')
  latitud = $('#caso_migracion_attributes_' + pid[3] + '_' + campoubi + '_latitud')
  longitud = $('#caso_migracion_attributes_' + pid[3] + '_' + campoubi + '_longitud')
  id = $(elemento).val()
  root = window
  $.getJSON(root.puntomontaje + "admin/" + ubi_plural +".json", function(o){
    ubi = o.filter(function(item){
      return item.id == id
    })
    if(ubi[0]){
      if(ubi[0].latitud){
        latitud.val(ubi[0].latitud).trigger('chosen:updated')
        longitud.val(ubi[0].longitud).trigger('chosen:updated')
      }
    }else{
      latitud.val(null).trigger('chosen:updated')
      longitud.val(null).trigger('chosen:updated')
    }
  });
}

function deshabilita_otros_sinohaymun(e, campoubi){
  pid = e.target.getAttribute('id').split('_')
  lugar = $('#caso_migracion_attributes_' + pid[3] + '_' + campoubi + '_lugar')
  sitio = $('#caso_migracion_attributes_' + pid[3] + '_' + campoubi + '_sitio')
  tsitio = $('#caso_migracion_attributes_' + pid[3] + '_' + campoubi + '_tsitio_id')
  latitud = $('#caso_migracion_attributes_' + pid[3] + '_' + campoubi + '_latitud')
  longitud = $('#caso_migracion_attributes_' + pid[3] + '_' + campoubi + '_longitud')
  lugar.val("")
  lugar.attr('disabled', true).trigger('chosen:updated')
  sitio.val(null)
  sitio.attr('disabled', true).trigger('chosen:updated')
  tsitio.val(1)
  tsitio.attr('disabled', true).trigger('chosen:updated')
  latitud.val("")
  latitud.attr('disabled', true).trigger('chosen:updated')
  longitud.val("")
  longitud.attr('disabled', true).trigger('chosen:updated')
}

function habilita_otros_sihaymun(e, tipo, campoubi){
  pid = e.target.getAttribute('id').split('_')
  lugar = $('#caso_migracion_attributes_' + pid[3] + '_' + campoubi + '_lugar')
  sitio = $('#caso_migracion_attributes_' + pid[3] + '_' + campoubi + '_sitio')
  tsitio = $('#caso_migracion_attributes_' + pid[3] + '_' + campoubi + '_tsitio_id')
  latitud = $('#caso_migracion_attributes_' + pid[3] + '_' + campoubi + '_latitud')
  longitud = $('#caso_migracion_attributes_' + pid[3] + '_' + campoubi + '_longitud')
  if(tipo == 1){
    lugar.attr('disabled', false).trigger('chosen:updated')
    tsitio.attr('disabled', false).trigger('chosen:updated')
  }
  if(tipo == 2){
    sitio.attr('disabled', false).trigger('chosen:updated')
    latitud.attr('disabled', false).trigger('chosen:updated')
    longitud.attr('disabled', false).trigger('chosen:updated')
  }
}
