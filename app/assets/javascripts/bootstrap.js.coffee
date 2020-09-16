jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()


# Elije ubicacionpre en autocompletación
# Tras autocompletar disparar el evento sip:autocompletada-ubicacionpre
@sip_autocompleta_ubicacionpre = (etiqueta, id, ubipre, root) ->
  sip_arregla_puntomontaje(root)
  #cs = id.split(";")
  #ubicacionpre_id = cs[0]
  #debugger
  ubipre.find('[id$=ubicacionpre_id]').val(id)
  ubipre.find('[id$=ubicacionpre_texto]').val(etiqueta)
  $(document).trigger("sip:autocompletada-ubicacionpre")
  return


# Busca ubicacionpre por nombre pais, nombre dep, nombre mun, nombre clase
# s es objeto con foco donde se busca ubicacionpre
@sip_busca_ubicacionpre = (s) ->
  root = window
  sip_arregla_puntomontaje(root)
  cnom = s.attr('id')
  v = $("#" + cnom).data('autocompleta')
  if (v != 1 && v != "no") 
    $("#" + cnom).data('autocompleta', 1)
    # Buscamos un div con clase div_ubicacionpre dentro del cual
    # están tanto el campo ubicacionpre_id como el campo
    # ubicacionpre_texto 
    ubipre = s.closest('.div_ubicacionpre')
    if (typeof ubipre == 'undefined')
      alert('No se ubico .div_ubicacionpre')
      return
    if $(ubipre).find("[id$='ubicacionpre_id']").length != 1
      alert('Dentro de .div_ubicacionpre no se ubicó ubicacionpre_id')
      return
    if $(ubipre).find("[id$='ubicacionpre_texto']").length != 1
      alert('Dentro de .div_ubicacionpre no se ubicó ubicacionpre_texto')
      return

    $("#" + cnom).autocomplete({
      source: root.puntomontaje + "ubicacionespre.json",
      minLength: 2,
      select: ( event, ui ) -> 
        if (ui.item) 
          sip_autocompleta_ubicacionpre(ui.item.value, ui.item.id, ubipre, root)
          event.stopPropagation()
          event.preventDefault()
    })
  return


# En listado de asistencia permite autocompletar nombres
$(document).on('focusin',
  'input[id^=actividad_ubicacionpre_texto]', (e) -> 
   sip_busca_ubicacionpre($(this))
)

# En formulario de actividad si escoge Plan Estratégico y Asistencia humanitaria se despliega nueva sección con tabla de detalles financieros
$(document).on('change', 'select[id^=actividad_actividad_proyectofinanciero_attributes][id$=_proyectofinanciero_id]', (e) ->
)
# En formulario de caso-migracion si elige otra causa muestra campo para especificarla
$(document).on('change', 'select[id^=caso_migracion_attributes_][id$=causamigracion_id]', (e) ->
  res = $(this).val()
  id_causa = $(this).attr('id') 
  div_otracausa = $('#' + id_causa).parent().next()
  if (res == '11')
   div_otracausa.css("display", "block")
  else
   div_otracausa.css("display", "none")
)

# En formulario de caso-migracion si elige otro miembro familiar, muestra campo para especificarla
$(document).on('change', 'select[id^=caso_migracion_attributes_][id$=miembrofamiliar_id]', (e) ->
  res = $(this).val()
  id_miembro = $(this).attr('id') 
  div_otracausa = $('#' + id_miembro).parent().next()
  if (res == '6')
    div_otracausa.css("display", "block")
  else
    div_otracausa.css("display", "none")
)

# En formulario de caso-migracion si elige otra autoridad ante la cual declarar, muestra campo para especificarla
$(document).on('change', 'select[id^=caso_migracion_attributes_][id$=autoridadrefugio_id]', (e) ->
  res = $(this).val()
  id_auto = $(this).attr('id') 
  div_otracausa = $('#' + id_auto).parent().next()
  if (res == '5')
   div_otracausa.css("display", "block")
  else
   div_otracausa.css("display", "none")
)

# En formulario de caso-migración si en causa de la agresión es Otra agrega respuesta abierta
$(document).on('change', 'select[id^=caso_migracion_attributes_][id$=causaagresion_ids]', (e) ->
  res = $(this).val()
  id_causaagresion = $(this).attr('id')
  div_otra = $('#' + id_causaagresion).parent().next()
  if (res.includes('8'))
   div_otra.css("display", "block")
  else
   div_otra.css("display", "none")
)

# En formulario de caso-migracion si pagó por ingreso a colombia muestra campos de detalles
$(document).on('change', 'select[id^=caso_migracion_attributes_][id$=pagoingreso_id]', (e) ->
  res = $(this).val()
  id_pago = $(this).attr('id').replace('pagoingreso_id', 'valor_pago')  
  div_detalles = $('#' + id_pago).closest('.detalles_pago')
  if (res == '2')
   div_detalles.css("display", "block")
  else
   div_detalles.css("display", "none")
)

# En formulario de caso-migración si en causa agresión en país  es Otra agrega respuesta abierta
$(document).on('change', 'select[id^=caso_migracion_attributes_][id$=causaagrpais_ids]', (e) ->
  res = $(this).val()
  id_causaagresion = $(this).attr('id')
  div_otra = $('#' + id_causaagresion).parent().next()
  if (res.includes('8'))
    div_otra.css("display", "block")
  else
   div_otra.css("display", "none")
)

# En formulario de caso-migración si en agresión durante la migración es Otra agrega respuesta abierta
$(document).on('change', 'select[id^=caso_migracion_attributes_][id$=agresionmigracion_ids]', (e) ->
  res = $(this).val()
  id_agresion = $(this).attr('id')
  div_otra = $('#' + id_agresion).parent().next()
  if (res.includes('13'))
   div_otra.css("display", "block")
  else
   div_otra.css("display", "none")
)

# En migración, si cambia fecha se calcula el tiempo en el país
$(document).on('change', 'input[id^=caso_migracion_attributes_][id$=_fechallegada]', (e) ->
  input_dias = $('input[id^=caso_migracion_attributes_][id$=_tiempoenpais]')
  divtiempoenpais = $(this).parent().parent().parent().next().find($(".div_tiempo"))
  tiempoenpais = $(this).parent().parent().parent().next().find(input_dias)
  divtiempoenpais.css("display", "block")
  fechallegada = new Date($(this).val())
  fechahoy = new Date()
  dif = fechahoy - fechallegada;
  dias = Math.round(dif / 86400000);
  tiempoenpais.val(dias)
)

# En listado de asistencia permite autocompletar nombres
$(document).on('focusin',
'input[id^=actividad_asistencia_attributes_]'+
'[id$=_persona_attributes_numerodocumento]',
(e) ->
  cor1440_gen_busca_asistente($(this))
)

# Llena campos clasificacion y subclasificacion de desplazamiento
@llena_clasifdesp = (ide, idl, jqthis) ->
  ee = $("#" + ide)
  ve = ee.val()
  te = $('#' + ide + " option[value='" + ve + "']").text()
  #fe = ee.find('option[value=' + ve + ']')
  #te = fe.text()	
  pe = te.split(" / ")
  el = $("#" + idl)
  vl = el.val()
  tl = $('#' + idl + " option[value='" + vl + "']").text()
  #fl = el.find('option[value=' + vl + ']')
  #tl = fl.text()
  pl = tl.split(" / ")
  cl = ""
  if pe.length > 0 && pl.length > 0
    if pe[0] != pl[0] 
      cl = "TRANSFRONTERIZO"
    else
      cl = "INTERDEPARTAMENTAL"
      if pe.length > 1 && pl.length > 1 && pe[1] == pl[1]
        cl = "INTERMUNICIPAL"
        if pe.length > 2 && pl.length > 2 && pe[2] == pl[2]
          cl = "DENTRO DE UN MUNICIPIO"
          if pe.length == 4 && pl.length == 4 && pe[3] == pl[3]
            cl = "INTRAURBANO"
  ue = "RURAL"
  if pe.length == 4
    ue = "URBANO"
  ul = "RURAL"
  if pl.length == 4
    ul = "URBANO"
  jqthis.parent().parent().find('input[name=clasificacion]').val(cl)
  jqthis.parent().parent().find('input[name=subclasificacion]').val(ue + " - " + ul)

# En desplazamientos al cambiar sitio de salida o llegada se recalcula clasificación y subclasificación de desplazamiento
$(document).on('change', 'select[id^=caso_desplazamiento_attributes_][id$=id_expulsion]', (e) ->
  ide=$(this).attr('id')
  idl=ide.replace('expulsion', 'llegada') 
  llena_clasifdesp(ide, idl, $(this))
)

# En desplazamientos, lista de sitios de llegada se cálcula
$(document).on('change', 'select[id^=caso_desplazamiento_attributes_][id$=id_llegada]', (e) ->
  idl=$(this).attr('id')
  ide=idl.replace('llegada', 'expulsion') 
  llena_clasifdesp(ide, idl, $(this))
)


# Al pasar a pestaña desplazamientos se recalculan clasificaciones
$(document).on('click', 'a.fichacambia[href^="#desplazamiento"]', (e) ->
  # e.preventDefault() No prevenir para que opere normal el cambio de
  # pestaña que implementa sivel2_sjr
  $('select[id^=caso_desplazamiento_attributes_][id$=id_expulsion]').
    each((i, e) -> 
      ide=$(e).attr('id')
      idl=ide.replace('expulsion', 'llegada') 
      llena_clasifdesp(ide, idl, $(e))
      return
   )
  return
)

$(document).on 'ready page:load',  -> 

  $(document).on('click', '#vertical', (e) ->
    $('[data-behaviour~=datepicker]').datepicker({
      format: 'yyyy-mm-dd'
      autoclose: true
      todayHighlight: true
      language: 'es'
    })
  )

@agregar_colapsables_cocoon = (nombrecampo, posicion) ->
  hijos = $('.nested-fields.vic').length
  hijo = $('.nested-fields.vic')[posicion]
  id = posicion + 1
  objeto = $(hijo)
  if hijos > 0
    iditem = nombrecampo + 'colapsable' + id
    objeto.find('h3.tituloenlace').text('Integrante ' + id)
    objeto.find('a.itemvictima').attr('data-toggle', 'collapse')
    objeto.find('a.itemvictima').attr('href', '#' + iditem)
    objeto.find('div.divcolapse').attr('id', iditem)

$(document).on('cocoon:after-insert', '', (e, victima) ->
  hijos = $('.nested-fields.vic').length
  agregar_colapsables_cocoon('victima', hijos-1)
)

document.addEventListener('turbolinks:load', () ->
  items_victimas = $('.nested-fields.vic')
  if items_victimas.length > 0
    for item in [0 .. items_victimas.length-1]
      agregar_colapsables_cocoon('victima', item)
)

$(document).on('change', 'select[id^=actividad_actividad_proyectofinanciero_attributes_][id$=actividadpf_ids]', (e, res) ->
  val = $(this).val()
  div_detallefinanciero = $("#detallefinanciero")
  if val.includes("116")
    div_detallefinanciero.css("display", "block")
  else
    div_detallefinanciero.css("display", "none")
)

$(document).on('cocoon:before-remove', '#actividad_proyectofinanciero', (e, objetivo) ->
  $(this).find("select").each( (d) ->
    div_detallefinanciero = $("#detallefinanciero")
    valor = $(this).val()
    if valor.includes("116")
      div_detallefinanciero.css("display", "none")
  )
)

$(document).on('change', 'input[id^=actividad_detallefinanciero_attributes_][id$=_numeromeses]', (e, res) ->
  total = +$(this).val()
  numeroasistencia = $(this).parent().parent().next().find("select")
  $(numeroasistencia).empty()
  opciones=''
  opciones+='<option value='+i+'>'+i+'</option>' for i in [1..total]
  $(numeroasistencia).append(opciones)
)

$(document).on('change', 'input[id^=actividad_detallefinanciero_attributes][id$=_cantidad]', (e, res) ->
  cantidad = +$(this).val()
  valor_unitario = $(this).parent().parent().next().find("input")
  total = cantidad * +valor_unitario.val()
  input_total = $(this).parent().parent().next().next().find("input")
  $(input_total).val(total)
)

$(document).on('change', 'input[id^=actividad_detallefinanciero_attributes][id$=_valorunitario]', (e, res) ->
  valor_unitario = +$(this).val()
  cantidad = $(this).parent().parent().prev().find("input")
  total = +cantidad.val() * valor_unitario
  input_total = $(this).parent().parent().next().find("input")
  $(input_total).val(total)
)

$(document).on('cocoon:after-insert', '#filas_detallefinanciero', (e, objetivo) ->
  $('.chosen-select').chosen()
  pfs = []
  $('[id^=actividad_actividad_proyectofinanciero_attributes][id$=_proyectofinanciero_id]').each( (o) ->
    v = $(this).val()
    if (v != "")
      pfs.push(+v)
  )
  paramspf = {id: pfs}
  root = window
  sip_funcion_1p_tras_AJAX('proyectosfinancieros.json?filtro[busid]=' + pfs.join(","), paramspf, 
    actualiza_pf_op, objetivo, 
    'con Convenios Financiados', root)
)

@actualiza_pf_op = (root, resp, objetivo) ->
  otrospfid = []
  objetivo.siblings().not(':hidden').find('select').each(() -> 
    otrospfid.push(+this.value)
  )
  nuevasop = []
  resp.forEach((r) -> 
    if !otrospfid.includes(+r.id)
      nuevasop.push({'id': +r.id, 'nombre': r.nombre})
  )
  mipf = objetivo.find('select[id$=_proyectofinanciero_id]').attr('id')
  sip_remplaza_opciones_select(mipf, nuevasop, true, 'id', 'nombre', true)
  $('#' + mipf).val('')
  $('#' + mipf).trigger('chosen:updated')

$(document).on('change', 'select[id^=actividad_detallefinanciero_attributes_][id$=proyectofinanciero_id]', (e, res) ->
  $(e.target).attr('disabled', true)
  $(e.target).trigger('chosen:updated')
  idac = $(e.target).parent().siblings().find('select[id$=actividadpf_ids]').attr('id')
  root = window
  params = { pfl: [+$(this).val()]}
  sip_llena_select_con_AJAX2('actividadespf', params, 
    idac, 'con Actividades de convenio ' + $(this).val(), root,
    'id', 'nombre', null)
)
