# You can use CoffeeScript in this file: http://coffeescript.org/


# Modifica un enlace agregando parámetros que toma del formulario
# @elema this del enlace por modificar
# @veccv vector de elementos con valores por enviar como parámetros en enlace
# @datos otros valores por agregar como parámetros a enlace
@jrscol_agrega_paramscv = (elema, veccv, datos) ->

  #root =  window;
  #sip_arregla_puntomontaje(root)
  ruta = $(elema).attr('href') 
  sep = '?'
  veccv.forEach((v) ->
    elemv = $('#' + v)
    vcv = ''
    if elemv[0].nodeName == 'INPUT' && elemv[0].type == 'checkbox'
      vcv = elemv.prop('checked')
    else if elemv[0].nodeName == 'SELECT'
      vcv = elemv.val()
    ruta += sep + v + '=' + vcv
    sep = '&' 
  )
  for l,v of datos
    ruta += sep + l + '=' + v
    sep = '&' 

  $(elema).attr('href', ruta)


