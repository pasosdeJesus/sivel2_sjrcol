jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()

$(document).on 'ready page:load',  -> 

  $(document).on('clik', '#vertical', (e) ->
    $('[data-behaviour~=datepicker]').datepicker({
      format: 'yyyy-mm-dd'
      autoclose: true
      todayHighlight: true
      language: 'es'
    })
  )


