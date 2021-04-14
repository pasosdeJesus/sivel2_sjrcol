
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

