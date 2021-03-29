
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
    var restoubipre = $(this).parent().parent().parent().next().children()[5]
    var ld = document.getElementById('caso_migracion_attributes_'+pid[3]+
      '_destino_lugar').parentElement
    var sd = document.getElementById('caso_migracion_attributes_'+pid[3]+
      '_destino_sitio').parentElement
    var tsd = document.getElementById('caso_migracion_attributes_'+pid[3]+
      '_destino_tsitio_id').parentElement
    var latd = document.getElementById('caso_migracion_attributes_'+pid[3]+
      '_destino_latitud').parentElement
    var lond = document.getElementById('caso_migracion_attributes_'+pid[3]+
      '_destino_longitud').parentElement
    if (+evento.target.value != 2) {
      pd.style.display = 'none'
      dd.style.display = 'none'
      md.style.display = 'none'
      cd.style.display = 'none'
      fd.style.display = 'none'
      restoubipre.style.display = 'none'
      ld.style.display = 'none'
      sd.style.display = 'none'
      tsd.style.display = 'none'
      latd.style.display = 'none'
      lond.style.display = 'none'
    } else {
      pd.style.display = ''
      dd.style.display = ''
      md.style.display = ''
      cd.style.display = ''
      fd.style.display = ''
      restoubipre.style.display = ''
      ld.style.display = ''
      sd.style.display = ''
      tsd.style.display = ''
      latd.style.display = ''
      lond.style.display = ''
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

$(document).on('focusin', 
'input[id^=caso_migracion_attributes][id$=_salida_lugar]', 
  function(e) {
    root = window
    pais = $(this.parentNode.parentNode.parentNode.parentNode.previousElementSibling.children[1].children[0].children[0]).val()
    dep = $(this.parentNode.parentNode.parentNode.parentNode.previousElementSibling.children[2].children[0].children[0]).val()
    mun = $(this.parentNode.parentNode.parentNode.parentNode.previousElementSibling.children[3].children[0].children[0]).val()
    clas = $(this.parentNode.parentNode.previousElementSibling.children[0].children[0]).val()
    ubi = [pais, dep, mun, clas]
    busca_ubicacionpre_lugar($(this), ubi)
  }
)

$(document).on('focusin', 
'input[id^=caso_migracion_attributes][id$=_llegada_lugar]', 
  function(e) {
    root = window
    pais = $(this.parentNode.parentNode.parentNode.parentNode.previousElementSibling.children[1].children[0].children[0]).val()
    dep = $(this.parentNode.parentNode.parentNode.parentNode.previousElementSibling.children[2].children[0].children[0]).val()
    mun = $(this.parentNode.parentNode.parentNode.parentNode.previousElementSibling.children[3].children[0].children[0]).val()
    clas = $(this.parentNode.parentNode.previousElementSibling.children[0].children[0]).val()
    ubi = [pais, dep, mun, clas]
    busca_ubicacionpre_lugar($(this), ubi)
  }
)

$(document).on('focusin', 
'input[id^=caso_migracion_attributes][id$=_destino_lugar]', 
  function(e) {
    root = window
    pais = $(this.parentNode.parentNode.parentNode.parentNode.previousElementSibling.children[1].children[0].children[0]).val()
    dep = $(this.parentNode.parentNode.parentNode.parentNode.previousElementSibling.children[2].children[0].children[0]).val()
    mun = $(this.parentNode.parentNode.parentNode.parentNode.previousElementSibling.children[3].children[0].children[0]).val()
    clas = $(this.parentNode.parentNode.previousElementSibling.children[0].children[0]).val()
    ubi = [pais, dep, mun, clas]
    busca_ubicacionpre_lugar($(this), ubi)
  }
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
          autocompleta_ubicacionpre_lugar(ui.item.tsitio_id, ui.item.lugar, ui.item.sitio, ui.item.latitud, ui.item.longitud, ubipre, root)
          event.stopPropagation()
          event.preventDefault()
        }
      }
    })
  }
  return
}

function autocompleta_ubicacionpre_lugar(tsit, lug, sit, lat, lon, ubipre, root){
  sip_arregla_puntomontaje(root)
  ubipre.find('[id$=_lugar]').val(lug)
  ubipre.find('[id$=_sitio]').val(sit)
  ubipre.find('[id$=_latitud]').val(lat)
  ubipre.find('[id$=_longitud]').val(lon)
  ubipre.find('[id$=_tsitio_id]').val(tsit).trigger('chosen:updated')
  $(document).trigger("sip:autocompletada-ubicacionpre")
  return
}
