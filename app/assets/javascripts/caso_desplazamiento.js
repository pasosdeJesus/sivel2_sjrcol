
//= require caso_migracion

$(document).on('change',
  'input[type=radio][name$="[establecerse]"]',
  function (evento) {
    pid = evento.target.getAttribute('id').split('_')
    if (evento.target.value == "false") {
      d = 'block'
    } else {
      d = 'none'
    }
    $(evento.target).closest('.controls').
      find('[id^=ubicacionpre-destino]').css('display', d)
  }
)


ubicacionpre2expandible_registra(
  'caso_desplazamiento_attributes', 'expulsion', window)

ubicacionpre2expandible_registra(
  'caso_desplazamiento_attributes', 'llegada', window)

ubicacionpre2expandible_registra(
  'caso_desplazamiento_attributes', 'destino', window)


$(document).on('cocoon:after-insert', '#desplazamiento',
  function (e) {
    $('[data-behaviour~=datepicker]').datepicker({
      format: 'yyyy-mm-dd',
      autoclose: true,
      todayHighlight: true,
      language: 'es',
    })
    $('.chosen-select').chosen()

    // Poner ids para expandir/contraer ubicaciones
    // Debe estar en sincronia con
    // app/views/sip/ubicacionpre/_dos_filas_confecha
    control = $('#ubicacionpre-expulsion-0').parent()
    cocoonid = control.find('[id$=fechaexpulsion]').attr('id').split('_')[3]

    console.log(cocoonid);

    ['expulsion', 'llegada', 'destino'].forEach(function (v, i) {
      ubicacionpre2expandible_cambia_ids(v, cocoonid)
    })
  }
)

$(document).on("click", ".togglepr", function() {
 $(this).parent().siblings(".nuevopr").modal('toggle');
});
// Nuevo Presunto responsable desde actos
$(document).on("click", ".boton_agregarpr", function(e) {
  e.preventDefault()
  desplazamiento = $(this).attr('data-desplazamiento')
  root =  window
  tn = Date.now()
  d = -1
  if (root.tagregapr){ 
    d = (tn - root.tagregapr)/1000
  }
  if (d == -1 || d>5){ 
    f=$('form')
    a = root.puntomontaje + 'actos/agregarpr?desplazamiento=' + desplazamiento
    $.post(a, f.serialize())
    root.tagregapr= Date.now()
  }
  return
});
