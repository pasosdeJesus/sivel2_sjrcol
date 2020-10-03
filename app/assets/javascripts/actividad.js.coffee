
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


@actualiza_opciones_convenioactividad = () ->
  apfs_total = calcula_pfapf_seleccionadas()
  apfs = apfs_total[0]
  apfs_abreviadas = apfs_total[1]
  $('select[id^=actividad_detallefinanciero_attributes_][id$=convenioactividad]').each((o) ->
    if $(this).val() == "" || $(this).val() == null
      miselect = $(this)
      miselectid = $(this).attr('id')
      nuevasop = apfs
      nuevasop_text = apfs_abreviadas
      miselect.empty()
      $(nuevasop).each( (o) ->
        miselect.append($("<option></option>")
         .attr("value", nuevasop[o]).text(nuevasop_text[o]))
      )
      $('#' + miselectid).val('')
      $('#' + miselectid).trigger('chosen:updated')
  )

@calcula_pfapf_seleccionadas = () ->
  apfs = []
  apfs_abreviadas = []
  $('[id^=actividad_actividad_proyectofinanciero_attributes][id$=_actividadpf_ids] option:selected').each( (o) ->
    v = $(this).text()
    pf = $(this).parent().parent().parent().prev().find('select[id$=_proyectofinanciero_id] option:selected').text()
    apf_sincod = v.substr(v.indexOf(': ')+1)
    if (pf != "" && pf != "PLAN ESTRATÉGICO 1" && apf_sincod != "")
      valor = pf + " -" + apf_sincod
      if (pf.length > 6)
        valor_abre = pf.substring(0, 5) + "..." + " -" + apf_sincod
      else
        valor_abre = valor
      apfs.push(valor)
      apfs_abreviadas.push(valor_abre)
  )
  return [apfs, apfs_abreviadas]
  
$(document).on('change', 'select[id^=actividad_actividad_proyectofinanciero_attributes_][id$=actividadpf_ids]', (e, res) ->
  valida_visibilidad_detallefinanciero()
  actualiza_opciones_convenioactividad()
)

$(document).on('cocoon:after-remove', '#actividad_proyectofinanciero', (e, objetivo) ->
  valida_visibilidad_detallefinanciero()
  actualiza_opciones_convenioactividad()
)

$(document).on('cocoon:after-insert', '#filas_detallefinanciero', (e, objetivo) ->
  $('.chosen-select').chosen()
  actualiza_opciones_convenioactividad()
 )

$(document).on('change', 'select[id^=actividad_detallefinanciero_attributes_][id$=convenioactividad]', (e, res) ->
  $(e.target).attr('disabled', true)
  $(e.target).trigger('chosen:updated')
)
$(document).on('change', 'select[id^=actividad_detallefinanciero_attributes_][id$=_modalidadentrega_id]', (e, res) ->
  valor = +$(this).val()
  tipotrans = $(this).parent().next()
  if valor != 1
    tipotrans.css('display', 'block')
  else
    tipotrans.css('display', 'none')
)

$(document).on('change', 'input[id^=actividad_detallefinanciero_attributes_][id$=_numeromeses]', (e, res) ->
  total = +$(this).val()
  numeroasistencia = $(this).parent().parent().next().find("select")
  $(numeroasistencia).empty()
  opciones = ''
  opciones += '<option value='+i+'>'+i+'</option>' for i in [1..total]
  $(numeroasistencia).append(opciones)
)

@recalcular_detallefinanciero_valortotal = (fila) ->
  cantidad = +fila.find('input[id^=actividad_detallefinanciero_attributes][id$=_cantidad]').val()
  valorunitario = +fila.find('input[id^=actividad_detallefinanciero_attributes][id$=_valorunitario]').val()
  numbenef = 0
  if typeof fila.find('select[id^=actividad_detallefinanciero_attributes][id$=_persona_ids]').val() == 'object'
    numbenef = fila.find('select[id^=actividad_detallefinanciero_attributes][id$=_persona_ids]').val().length
  total = cantidad * valorunitario * numbenef
  fila.find('input[id^=actividad_detallefinanciero_attributes][id$=_valortotal]').val(total)

$(document).on('change', 'input[id^=actividad_detallefinanciero_attributes][id$=_cantidad]', (e, res) ->
  recalcular_detallefinanciero_valortotal($(this).parent().parent().parent())
)

$(document).on('change', 'input[id^=actividad_detallefinanciero_attributes][id$=_valorunitario]', (e, res) ->
  recalcular_detallefinanciero_valortotal($(this).parent().parent().parent())
)

$(document).on('change', 'select[id^=actividad_detallefinanciero_attributes][id$=_persona_ids]', (e, res) ->
  recalcular_detallefinanciero_valortotal($(this).parent().parent().parent())
)

#
#  ACTUALIZA DINAMICAMENTE BENEFICIARIO(S) DIRECTO(S) EN DETALLEFINANCIERO
#


@jrs_persona_presenta_nombre = (nombres, apellidos, tdocumento_sigla = null, numerodocumento = null) ->
  ip = ''
  if typeof numerodocumento != 'undefined'  && numerodocumento != ''
    ip = numerodocumento
  if typeof tdocumento_sigla != 'undefined' && tdocumento_sigla != ''
    ip = tdocumento_sigla + ":" + ip
  r = nombres + " " + apellidos + " (" + ip + ")"
  r

@jrs_refresca_posibles_beneficiarios_casos_asistentes = (root, res) ->
  # Recorre listado de casos (sin _destroy) y recorre listado de 
  # asistentes (sin _destroy) para recolectar personas y de cada una 
  # lo necesario para presentarlas en columna Beneficiario(s) Directo(s)
  # del detall financiero

  # Procesamos personas en casos que recibimos
  posbenef = []
  console.log('El resultado res es: ', res)
  for p in res
      n = jrs_persona_presenta_nombre(p.nombres, p.apellidos, p.tdocumento_sigla, p.numerodocumento)
      posbenef.push({id: p.persona_id, nombre: n})

  $('[id^=actividad_asistencia_attributes][id$=__destroy]').each((i,v) ->
    # excluye asistentes destruidos
    if $(this).val() != "1"
      personaid = $(this).parent().parent().find("[id$=_persona_attributes_id]").val()
      nombres = $(this).parent().parent().find("[id$=_nombres]").val()
      apellidos = $(this).parent().parent().find("[id$=_apellidos]").val()
      tdocumento_sigla = $(this).parent().parent().find("[id$=_tdocumento_id]").children('option:selected').text()
      numerodocumento = $(this).parent().parent().find("[id$=_numerodocumento]").val()
      n = jrs_persona_presenta_nombre(nombres, apellidos, tdocumento_sigla, numerodocumento)
      posbenef.push({id: personaid, nombre: n})
  )

  posbenef.sort((a, b) ->
    na = a.nombre.toUpperCase()
    nb = b.nombre.toUpperCase()
    if na < nb
      -1
    else if na > nb
      1
    else
      0
  )

  posbenefu = posbenef.filter( (valor, indice, self) ->
    self.indexOf(valor) == indice
  )
  # Aquí modificamos los campos beneficiario_directo
  $('[id^=actividad_detallefinanciero_attributes_][id$=__destroy]').each((i,v) ->
    # Excluye filas de detalle destruidas
    if $(this).val() != "1"
      idpi = $(this).parent().parent().find("[id$=_persona_ids]").attr('id');
      sip_remplaza_opciones_select(idpi, posbenefu, true);
  )


@jrs_refresca_posibles_beneficiarios_casos = () ->
  cids = []
  $('[id^=actividad_actividad_casosjr_][id$=__destroy]').each((i,v) ->
    # excluye casos destruidos
    if $(this).val() != "1"
      casoid = $(this).parent().parent().find("a").first().text()
      cids.push(casoid)
  )
  console.log('El arreglo cids es:', cids)
  console.log(cids)
  sip_ajax_recibe_json(window, 'personas_casos', {caso_ids: cids.join(',')},
    jrs_refresca_posibles_beneficiarios_casos_asistentes)


# En actividad tras cambiar nombres de asistente refrescar beneficiario posibles
$(document).on('change', '[id^=actividad_asistencia_attributes][id$=_nombres]', (e, objetivo) ->
  jrs_refresca_posibles_beneficiarios_casos()
)

# En actividad tras cambiar apellidos de asistente refrescar beneficiario posibles
$(document).on('change', '[id^=actividad_asistencia_attributes][id$=_apellidos]', (e, objetivo) ->
  jrs_refresca_posibles_beneficiarios_casos()
)

# En actividad tras cambiar tipo de documento refrescar beneficiario posibles
$(document).on('change', '[id^=actividad_asistencia_attributes][id$=_tdocumento_id]', (e, objetivo) ->
  jrs_refresca_posibles_beneficiarios_casos()
)

# Tras cambiar número de documento refrescar beneficiario posibles
$(document).on('change', '[id^=actividad_asistencia_attributes][id$=_numerodocumento]', (e, objetivo) ->
  jrs_refresca_posibles_beneficiarios_casos()
)

# Tras eliminar caso beneficiario refrescar beneficiarios posibles
$(document).on('cocoon:after-remove', '#actividad_casosjr', (e, papa) ->
  jrs_refresca_posibles_beneficiarios_casos()
)

# Tras eliminar asistente refrescar beneficiarios posibles
$(document).on('cocoon:after-remove', '#asistencia', (e, papa) ->
  jrs_refresca_posibles_beneficiarios_casos()
)

# Tras autocompletar asistente refrescar beneficiarios posibles
$(document).on('cor1440gen:autocompletado-asistente', (e, papa) ->
  jrs_refresca_posibles_beneficiarios_casos()
)

# Tras autocompletar caso beneficiario refrescar beneficiarios posibles
$(document).on('sivel2sjr:autocompletado-contactoactividad', (e, papa) ->
  console.log('entro por evento autocompletado-contactoactividad')
  jrs_refresca_posibles_beneficiarios_casos()
)


