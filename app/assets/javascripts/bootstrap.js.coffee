jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()


# En listado de asistencia permite autocompletar nombres
$(document).on('focusin',
'input[id^=actividad_asistencia_attributes_]'+
'[id$=_persona_attributes_numerodocumento]',
(e) ->
  cor1440_gen_busca_asistente($(this))
)

@autocompleta_ubicacion = (label, id, id_victima, divcp, root) ->
  sip_arregla_puntomontaje(root)
  cs = id.split(";")
  id_persona = cs[0]
  pl = []
  ini = 0
  for i in [0..cs.length] by 1
     t = parseInt(cs[i])
     pl[i] = label.substring(ini, ini + t)
     ini = ini + t + 1
  # pl[1] cnom, pl[2] es cape, pl[3] es cdoc
  d = "id_victima=" + id_victima
  d += "&id_persona=" + id_persona
  a = root.puntomontaje + 'personas/remplazar'
  $.ajax(url: a, data: d, dataType: "html").fail( (jqXHR, texto) ->
    alert("Error: " + jqXHR.responseText)
  ).done( (e, r) ->
    divcp.html(e)
    $(document).trigger("sip:autocompleto_persona", [id_victima, id_persona])
    return
  )
  return

@busca_ubicacion = (s) ->
  root = window
  sip_arregla_puntomontaje(root)
  cnom = s.attr('id')
  v = $("#" + cnom).data('autocompleta')
  if (v != 1 && v != "no") 
    $("#" + cnom).data('autocompleta', 1)
    divcp = s.closest('.campos_persona')
    if (typeof divcp == 'undefined')
      alert('No se ubico .campos_persona')
      return
    ubis = root.puntomontaje + $("#" + cnom).data("autocomplete-source")
    $("#" + cnom).autocomplete({
      source: ubis,
      minLength: 2,
      select: ( event, ui ) ->
        ubicaciones= ui.item.label.split("/")
        div_padre = $("#" + cnom).closest("div")
        div_pais = div_padre.nextAll().eq(0)
        div_dep = div_padre.nextAll().eq(1)
        div_mun = div_padre.nextAll().eq(2)
        input_pais = div_pais.find('select[id^=caso_victima_attributes_][id$=_persona_attributes_id_pais]')
        input_dep = div_dep.find('select[id^=caso_victima_attributes_][id$=_persona_attributes_id_departamento]')
        input_mun = div_mun.find('select[id^=caso_victima_attributes_][id$=_persona_attributes_id_municipio]')
        pais= $.trim(ubicaciones[3])
        departamento= $.trim(ubicaciones[2])
        municipio= $.trim(ubicaciones[1])
        x = $.getJSON(root.puntomontaje + "admin/paises?filtro%5Bbusid%5D=&filtro%5Bbusnombre%5D=" + pais)
        y = $.getJSON(root.puntomontaje + "admin/departamentos?filtro%5Bbusid%5D=&filtro%5Bbusnombre%5D=" + departamento)
        x.done( ( data ) ->
          id_pais = data[0].id
          input_pais.val(id_pais).trigger('chosen:updated')
        )
        y.done( ( data ) ->
          datad = data
          llena_departamento_congancho($(input_pais), root, sincoord=false, datad, input_dep)
          input_dep.trigger('chosen:updated')
          z = $.getJSON(root.puntomontaje + "admin/municipios?filtro%5Bbusid%5D=&filtro%5Bbusnombre%5D=" + municipio)
          z.done( ( data ) ->
            datam = data
            llena_municipio_congancho($(input_dep), root, sincoord=false, datam, input_mun)
            )
        )
    })
  return

# En pais de nacimiento permite autocompletar
# Pais - Dpto - Municipio - Centro Poblado
$(document).on('focusin',
'input[id^=caso_victima_attributes_]'+
'[id$=_persona_attributes_ubinacimiento]',
(e) ->
  busca_ubicacion($(this))
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
