# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

enviaFormulario = () ->
  f=$('form')
  a=f.attr('action')
  $.get(a, f.serialize())


$(document).on 'ready page:load',  -> 

  root = exports ? this
 
  $(document).on('changeDate', (e) ->
    enviaFormulario()
  )
  $(document).on('change', 'select input', (e) ->
    enviaFormulario()
  )


