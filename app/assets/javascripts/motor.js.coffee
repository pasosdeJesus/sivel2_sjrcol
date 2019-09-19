# You can use CoffeeScript in this file: http://coffeescript.org/


# Pone parametros de formulario en enlace para generar plantilla
# @elema this de boton Generar
# @idselplantilla id del campo de seleccion de plantilla
# @idruta ruta del formulario (e.g '/casos/filtro') si se deja
#   en blanco se usa el mas cercano a elema
# @rutagenera ruta por cargar con id de plantilla y valores del 
#   formulario e.g 'casos/genera/'
@jrscol_agrega_paramscv = (elema, veccv, datos) ->

  #root =  window;
  #sip_arregla_puntomontaje(root)
  ruta = $(elema).attr('href') 
  sep = '?'
  veccv.forEach((v) ->
    vcv = $('#' + v).prop('checked')
    ruta += sep + v + '=' + vcv
    sep = '&' 
  )
  for l,v of datos
    ruta += sep + l + '=' + v
    sep = '&' 

  $(elema).attr('href', ruta)


