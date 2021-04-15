
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

// Cambia id de elementos relacionados con el control de ubicacionpre
// expandible en 2 filas, que tengan id 0.
function ubicacionpre2expandible_cambia_ids(elemento, nuevaid) {
  control = $('#ubicacionpre-' + elemento + '-0').parent()
  control.find('#ubicacionpre-' + elemento + '-0').attr('id', 
    'ubicacionpre-' + elemento + '-'+ cocoonid)
  control.find('#resto-' + elemento + '-0').attr('id', 
    'resto-' + elemento + '-'+ cocoonid)
  control.find('#restocp-' + elemento + '-0').attr('id', 
    'restocp-' + elemento + '-'+ cocoonid)
  b = control.find('button[data-target$=' + elemento + '-0]')
  console.log(b.attr('data-target'))
  b.attr('data-target', 
    '#resto-' + elemento + '-' + cocoonid + ',#restocp-' + elemento + '-' + 
    cocoonid)
}

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
      ubicacionpre2expandible_cambia_ids(v, cocoonid)
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

function ubicacionpre2expandible_maneja_evento_busca_lugar(e) {
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
  ubicacionpre2expandible_busca_lugar($(this), ubi)
}


function ubicacionpre2expandible_busca_lugar(s, ubi) {
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
          ubicacionpre2expandible_autocompleta_lugar(ui.item.clase_id, ui.item.tsitio_id, ui.item.lugar, ui.item.sitio, ui.item.latitud, ui.item.longitud, ubipre, root)
          event.stopPropagation()
          event.preventDefault()
        }
      }
    })
  }
  return
}

function ubicacionpre2expandible_autocompleta_lugar(clase_id, tsit, lug, sit, lat, lon, ubipre, root){
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

// iniid Inicio de identificacion por ejemplo 'caso_migracion_attributes'
// elemento Identificación particular del que se registra por ejemplo 'salida'
//    (teniendo en cuenta que haya campos para el mismo, por ejemplo
//    uno terminado en salida_lugar).
// root Raiz
function ubicacionpre2expandible_registra(iniid, elemento, root) {
  sip_arregla_puntomontaje(root)

  // Buscador en campo lugar
  $(document).on('focusin', 
    'input[id^=' + iniid + '][id$=_' + elemento + '_lugar]', 
    ubicacionpre2expandible_maneja_evento_busca_lugar
  )

  // Cambia coordenadas al cambiar pais
  $(document).on('change', 
    '[id^=' + iniid + '][id$=' + elemento + '_pais_id]', function (evento) {
      fija_coordenadas(evento, elemento, $(this), "paises")
      deshabilita_otros_sinohaymun(evento, elemento)
    }
  )

  // Cambia coordenadas y deshabilita otros campos al cambiar departamento
  $(document).on('change', 
    '[id^=' + iniid + '][id$=' + elemento + '_departamento_id]', 
    function (evento) {
      if($(this).val() == "") {
        pid = evento.target.getAttribute('id').split('_')
        pais = $('#caso_migracion_attributes_' + pid[3] + '_' + campoubi + 
          '_pais_id')
        fija_coordenadas(evento, elemento, pais, "paises")
      } else {
        fija_coordenadas(evento, elemento, $(this), "departamentos")
      }
      deshabilita_otros_sinohaymun(evento, elemento)
    })

  // Cambia coordenadas y habilita otros campos al cambiar municipio
  $(document).on('change', 
    '[id^=' + iniid + '][id$=' + elemento + '_municipio_id]', 
    function (evento) {
      if($(this).val() == '') {
        pid = evento.target.getAttribute('id').split('_')
        dep = $('#caso_migracion_attributes_' + pid[3] + '_' + campoubi + 
          '_departamento_id')
        fija_coordenadas(evento, elemento, dep, "departamentos")
        deshabilita_otros_sinohaymun(evento, elemento)
      }else{
        fija_coordenadas(evento, elemento, $(this), "municipios")
        habilita_otros_sihaymun(evento, 1, elemento)
      }
    })

  // Cambia coordenadas y habilita otros campos al cambiar centro poblado
  $(document).on('change', 
    '[id^=' + iniid + '][id$=' + elemento + '_clase_id]', 
    function (evento) {
      if($(this).val()==""){
        pid = evento.target.getAttribute('id').split('_')
        mun = $('#caso_migracion_attributes_' + pid[3] + '_' + campoubi + 
          '_municipio_id')
        fija_coordenadas(evento, elemento, mun, "municipios")
      }else{
        fija_coordenadas(evento, elemento, $(this), "clases")
      }
      habilita_otros_sihaymun(evento, 1, elemento)
    })

  // Habilita otros campos al cambiar lugar
  $(document).on('change', 
    '[id^=' + iniid + '][id$=' + elemento + '_lugar]', 
    function (evento) {
      habilita_otros_sihaymun(evento, 2, elemento)
    }
  )

}

ubicacionpre2expandible_registra(
  'caso_migracion_attributes', 'salida', window)

ubicacionpre2expandible_registra(
  'caso_migracion_attributes', 'llegada', window)

ubicacionpre2expandible_registra(
  'caso_migracion_attributes', 'destino', window)


// Funciones
function fija_coordenadas(e, campoubi, elemento, ubi_plural){
  ubp = $(e.target).closest('.ubicacionpre')
  latitud = ubp.find('[id$='+campoubi+'_latitud]')
  longitud = ubp.find('[id$='+campoubi+'_longitud]')

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
  ubp = $(e.target).closest('.ubicacionpre')
  lugar = ubp.find('[id$='+campoubi+'_lugar]')
  sitio = ubp.find('[id$='+campoubi+'_sitio]')
  tsitio = ubp.find('[id$='+campoubi+'_tsitio_id]')
  latitud = ubp.find('[id$='+campoubi+'_latitud]')
  longitud = ubp.find('[id$='+campoubi+'_longitud]')
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
  ubp = $(e.target).closest('.ubicacionpre')
  lugar = ubp.find('[id$='+campoubi+'_lugar]')
  sitio = ubp.find('[id$='+campoubi+'_sitio]')
  tsitio = ubp.find('[id$='+campoubi+'_tsitio_id]')
  latitud = ubp.find('[id$='+campoubi+'_latitud]')
  longitud = ubp.find('[id$='+campoubi+'_longitud]')
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
