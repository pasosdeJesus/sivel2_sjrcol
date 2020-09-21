
# Elije ubicacionpre en autocompletación
# Tras autocompletar disparar el evento sip:autocompletada-ubicacionpre
@sip_autocompleta_ubicacionpre = (etiqueta, id, ubipre, root) ->
  sip_arregla_puntomontaje(root)
  #cs = id.split(";")
  #ubicacionpre_id = cs[0]
  #debugger
  ubipre.find('[id$=ubicacionpre_id]').val(id)
  ubipre.find('[id$=ubicacionpre_texto]').val(etiqueta)
  ubipre.find('[id$=ubicacionpre_mundep_texto]').val(etiqueta)
  $(document).trigger("sip:autocompletada-ubicacionpre")
  return


# Busca ubicacionpre por nombre de municipio o departamento en Colombia
# s es objeto con foco donde se busca ubicacionpre
@sip_busca_ubicacionpre_mundep = (s) ->
  root = window
  sip_arregla_puntomontaje(root)
  cnom = s.attr('id')
  v = $("#" + cnom).data('autocompleta')
  if (v != 1 && v != "no") 
    $("#" + cnom).data('autocompleta', 1)
    # Buscamos un div con clase div_ubicacionpre dentro del cual
    # están tanto el campo ubicacionpre_id como el campo
    # ubicacionpre_mundep_texto 
    ubipre = s.closest('.div_ubicacionpre')
    if (typeof ubipre == 'undefined')
      alert('No se ubico .div_ubicacionpre')
      return
    if $(ubipre).find("[id$='ubicacionpre_id']").length != 1
      alert('Dentro de .div_ubicacionpre no se ubicó ubicacionpre_id')
      return
    if $(ubipre).find("[id$='ubicacionpre_mundep_texto']").length != 1
      alert('Dentro de .div_ubicacionpre no se ubicó ubicacionpre_mundep_texto')
      return

    $("#" + cnom).autocomplete({
      source: root.puntomontaje + "ubicacionespre_mundep.json",
      minLength: 2,
      select: ( event, ui ) -> 
        if (ui.item) 
          sip_autocompleta_ubicacionpre(ui.item.value, ui.item.id, ubipre, root)
          event.stopPropagation()
          event.preventDefault()
    })
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
  'input[id^=actividad_ubicacionpre_mundep_texto]', (e) -> 
   sip_busca_ubicacionpre_mundep($(this))
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


# En listado de asistencia permite autocompletar nombres
$(document).on('focusin',
'input[id^=actividad_asistencia_attributes_]'+
'[id$=_persona_attributes_numerodocumento]',
(e) ->
  cor1440_gen_busca_asistente($(this))
)

@filtra_actividadespf_tipo_accionhum = (apfs_ids) ->
  root = window
  f_actividadespf = 'filtro[busid]=' + apfs_ids.join(",")
  f_tipo = 'filtro[busactividadtipo_id]=129'
  buscatipoactividad = (e, resp) ->
    div_detallefinanciero = $("#detallefinanciero")
    if resp.length > 0
      div_detallefinanciero.css("display", "block")
    else
      div_detallefinanciero.css("display", "none")
  sip_ajax_recibe_json(root, 'actividadespflistado.json?' + f_actividadespf + '&' + f_tipo, null, buscatipoactividad)

@valida_visibilidad_detallefinanciero = () ->
  actividadespf = []
  $('select[id^=actividad_actividad_proyectofinanciero_attributes_][id$=actividadpf_ids]').each( () ->
    val = $(this).val()
    actividadespf = $.merge(actividadespf, val)
  )
  filtra_actividadespf_tipo_accionhum(actividadespf)

$(document).on('change', 'select[id^=actividad_actividad_proyectofinanciero_attributes_][id$=actividadpf_ids]', (e, res) ->
  valida_visibilidad_detallefinanciero()
  actualiza_opciones_convenioactividad()
)

$(document).on('cocoon:after-remove', '#actividad_proyectofinanciero', (e, objetivo) ->
  valida_visibilidad_detallefinanciero()
  actualiza_opciones_convenioactividad()
)

@actualiza_opciones_convenioactividad = () ->
  apfs_inicial = calcula_pfapf_seleccionadas()
  excluidos = []
  $('select[id^=actividad_detallefinanciero_attributes_][id$=convenioactividad] option:selected').each((o) ->
    if $(this).text() != ""
      excluidos.push($(this).text())
  )
  apfs = apfs_inicial.filter((item) => !excluidos.includes(item))
  $('select[id^=actividad_detallefinanciero_attributes_][id$=convenioactividad]').each((o) ->
    if $(this).val() == ""
      miselect = $(this)
      miselectid = $(this).attr('id')
      nuevasop = apfs
      miselect.empty()
      $(nuevasop).each( (o) ->
        miselect.append($("<option></option>")
         .attr("value", nuevasop[o]).text(nuevasop[o]))
      )
      $('#' + miselectid).val('')
      $('#' + miselectid).trigger('chosen:updated')
  )

@calcula_pfapf_seleccionadas = () ->
  apfs = []
  $('[id^=actividad_actividad_proyectofinanciero_attributes][id$=_actividadpf_ids] option:selected').each( (o) ->
    v = $(this).text()
    pf = $(this).parent().parent().parent().prev().find('select[id$=_proyectofinanciero_id] option:selected').text()
    apf_sincod = v.substr(v.indexOf(' ')+1)
    if (pf != "" && pf != "PLAN ESTRATÉGICO 1" && apf_sincod != "")
      valor = pf + " - " + apf_sincod
      apfs.push(valor)
  )
  return apfs
  
$(document).on('cocoon:after-insert', '#filas_detallefinanciero', (e, objetivo) ->
  $('.chosen-select').chosen()
  actualiza_opciones_convenioactividad()
 )

$(document).on('change', 'select[id^=actividad_detallefinanciero_attributes_][id$=convenioactividad]', (e, res) ->
  $(e.target).attr('disabled', true)
  $(e.target).trigger('chosen:updated')
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
