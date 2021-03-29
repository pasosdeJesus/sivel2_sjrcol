
$(document).on('change', 
  'input[type=radio][name$="[establecerse]"]', 
  function (evento) {
    pid = evento.target.getAttribute('id').split('_')
    var pd = document.getElementById('caso_desplazamiento_attributes_'+pid[3]+
      '_destino_pais_id').parentElement
    var dd = document.getElementById('caso_desplazamiento_attributes_'+pid[3]+
      '_destino_departamento_id').parentElement
    var md = document.getElementById('caso_desplazamiento_attributes_'+pid[3]+
      '_destino_municipio_id').parentElement
    var cd = document.getElementById('caso_desplazamiento_attributes_'+pid[3]+
      '_destino_clase_id').parentElement
    var restoubipre = $(this).parent().parent().parent().parent().next().children()[5]
    var ld = document.getElementById('caso_desplazamiento_attributes_'+pid[3]+
      '_destino_lugar').parentElement
    var sd = document.getElementById('caso_desplazamiento_attributes_'+pid[3]+
      '_destino_sitio').parentElement
    var tsd = document.getElementById('caso_desplazamiento_attributes_'+pid[3]+
      '_destino_tsitio_id').parentElement
    var latd = document.getElementById('caso_desplazamiento_attributes_'+pid[3]+
      '_destino_latitud').parentElement
    var lond = document.getElementById('caso_desplazamiento_attributes_'+pid[3]+
      '_destino_longitud').parentElement
    if (evento.target.value != "true") {
      pd.style.display = 'none'
      dd.style.display = 'none'
      md.style.display = 'none'
      cd.style.display = 'none'
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
      restoubipre.style.display = ''
      ld.style.display = ''
      sd.style.display = ''
      tsd.style.display = ''
      latd.style.display = ''
      lond.style.display = ''
    }
  }
)

