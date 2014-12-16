# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

enviaFormularioContar= () ->
  f = $('form')
  a = f.attr('action')
  d = f.serialize()
  d += '&commit=Contar'
  $.ajax(url: a, data: d, dataType: "script").fail( (jqXHR, texto) ->
    alert("Error con ajax " + texto)
  )
  #$.get(a, f.serialize())
  return


$(document).on 'ready page:load',  -> 

  root = exports ? this

  # ha afectado ficha caso en ocasiones, por eso se elije sólo los que
  # tengan
  # afectando ficha caso 
  $(document).on('changeDate', '[data-contarautomatico]', 
    (e) -> enviaFormularioContar()
  )
  $(document).on('change', 'select[data-contarautomatico]', 
    (e) -> enviaFormularioContar()
  )
  $(document).on('change', 'input[data-contarautomatico]', 
    (e) -> enviaFormularioContar()
  )


