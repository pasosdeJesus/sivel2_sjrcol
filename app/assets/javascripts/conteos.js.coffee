# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


# Envia con AJAX datos del formulario, junto con el botón Contar.
# @param root Raiz del documento, para guardar allí variable global.
enviaFormularioContar= (root) ->
  f = $('form')
  a = f.attr('action')
  d = f.serialize()
  d += '&commit=Contar'
  # Parece que en ocasiones lanza 2 veces seguidas el mismo evento
  # y PostgreSQL produce error por 2 creaciones practicamente
  # simultaneas de la vista. Evitamos enviar lo mismo.
  if (!root.dant || root.dant != d)
    $.ajax(url: a, data: d, dataType: "script").fail( (jqXHR, texto) ->
      alert("Error con ajax " + texto)
    )
  root.dant = d 
  return


$(document).on 'ready page:load',  -> 

  root = exports ? this

  # ha afectado ficha caso en ocasiones, por eso se elije sólo los que
  # tengan
  # afectando ficha caso 
  $(document).on('changeDate', '[data-contarautomatico]', 
    (e) -> enviaFormularioContar(root)
  )

  $(document).on('change', 'select[data-contarautomatico]', 
    (e) -> enviaFormularioContar(root)
  )

  $(document).on('change', 'input[data-contarautomatico]:not([data-behaviour])', 
    (e) -> enviaFormularioContar(root)
  )


