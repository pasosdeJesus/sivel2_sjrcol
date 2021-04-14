
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


registra_ubicacionpre_control2expandible(
  'caso_desplazamiento_attributes', 'expulsion', window)

registra_ubicacionpre_control2expandible(
  'caso_desplazamiento_attributes', 'llegada', window)

registra_ubicacionpre_control2expandible(
  'caso_desplazamiento_attributes', 'destino', window)

