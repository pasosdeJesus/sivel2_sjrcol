# You can use CoffeeScript in this file: http://coffeescript.org/


# Modifica un enlace agregando parámetros que toma del formulario
# @elema this del enlace por modificar
# @veccv vector de elementos con valores por enviar como parámetros en enlace
# @datos otros valores por agregar como parámetros a enlace
@jrs_agrega_paramscv = (elema, veccv, datos) ->

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

# A partir del HTML llena rangos y objeto idrf, a su vez elimina duplicados 
#   de la tabla población
# @param rangos Hash con rangos de edad en base de datos
#   cada elemento es de la forma idbase=>[inf, sup]. Para el rango 
#   SIN INFORMACIÓN se espera convención que inf y sup sean -1 en base y aquí
# @param idrf Hash con las identificaciones de los elementos
#   de rango añadidos en la tabla, cada entrada es de la forma
#   idbase => idelemento
@jrs_identifica_ids_rangoedad = (rangos, idrf) ->
  cantr = $('#rangoedadac_cant').val()
  sin = -1
  res = -1
  for i in [0..cantr-1] 
    inf = $('#rangoedadac_d_' + i).data('inf')
    if inf != ''
      inf = +inf
    sup = $('#rangoedadac_d_' + i).data('sup')
    if sup!= ''
      sup = +sup
    idran = +$('#rangoedadac_d_' + i).val()
    if (inf == -1) 
      rangos[idran] = [-1,-1]
    else 
      rangos[idran] = [inf, sup]

  for i, r of rangos
    idrf[i] = -1
  # Llena id de elemento en formulario en idrf y borra redundantes.
  $('select[id^=actividad_actividad_rangoedadac_attributes_][id$=_rangoedadac_id]').each((i, v) ->
    nr = +$(this).val()
    if idrf[nr] != -1 # Repetido, unir con el inicial
      fl2 = $(this).parent().parent().find('input[id^=actividad_actividad_rangoedadac_attributes_][id$=_fl]').val()
      ml2 = $(this).parent().parent().find('input[id^=actividad_actividad_rangoedadac_attributes_][id$=_ml]').val()
      $(this).parent().parent().find('a.remove_fields').click()
      prl = '#actividad_actividad_rangoedadac_attributes_' + idrf[nr] 
      fl1 = $(prl + '_fl').val()
      ml1 = $(prl + '_ml').val()
      $(prl + '_fl').val(fl1 + fl2)
      $(prl + '_ml').val(ml1 + ml2)
    else
      idrf[nr] = /actividad_actividad_rangoedadac_attributes_(.*)_rangoedadac_id/.exec($(this).attr('id'))[1]
  )


# Aumenta valor en tabla población para el sexo y rango de edad dado en la cantidad 
# dada
@jrs_aumenta_poblacion=(idrf, sexo, idran, cantidad) ->
  if +cantidad == 0 
    return
  if idrf[idran] == -1 
    sivel2_sjr_aumenta_fila_poblacion(idrf, idran)
  pref = '#actividad_actividad_rangoedadac_attributes_' + idrf[idran]
  if sexo == 'F'
    fr = +$(pref + '_fr').val()
    $(pref + '_fr').val(fr + (+cantidad))
    cor1440_gen_rangoedadac($(pref + '_fr'))
  else    
    mr = +$(pref + '_mr').val()
    $(pref + '_mr').val(mr + (+cantidad))
    cor1440_gen_rangoedadac($(pref + '_mr'))

# Recalcula tabla poblacion en actividad a partir de listado de 
# personas beneficiarias  y de casos beneficiarios
@jrs_recalcula_poblacion = () ->
  if $('[id^=actividad_asistencia_attributes]').length > 0  || $('#actividad_casosjr').children().length > 1  

    # No permitiria añadir manualmente a población 
    # $('a[data-association-insertion-node$=actividad_rangoedadac]').hide()
    # Pone en blanco las cantidades y deshabilita edición
    $('input[id^=actividad_actividad_rangoedadac_attributes_][id$=_fr]').each((i, v) ->
      $(this).val(0)
      $(this).prop('readonly', true);
    )
    $('input[id^=actividad_actividad_rangoedadac_attributes_][id$=_mr]').each((i, v) ->
      $(this).val(0)
      $(this).prop('readonly', true);
    )

    # Identifica rangos de edad en base y en tabla resumiendo tabla si hace falta
    idrf={}
    rangos = {}
    jrs_identifica_ids_rangoedad(rangos, idrf)

    # Fecha del caso
    fap = $('#actividad_fecha_localizada').val().split('-')
    anioref  = +fap[0]
    mesref  = +fap[1]
    diaref  = +fap[2]

    # Recorre listado de personas
    $('[id^=actividad_asistencia_attributes][id$=_persona_attributes_anionac]').each((i, v) ->
      ida = /actividad_asistencia_attributes_(.*)_persona_attributes_anionac/.exec($(this).attr('id'))[1]
      anionac = $(this).val()
      mesnac = $('[id=actividad_asistencia_attributes_' + ida + '_persona_attributes_mesnac]').val()
      dianac = $('[id=actividad_asistencia_attributes_' + ida + '_persona_attributes_dianac]').val()

      e = +sivel2_gen_edadDeFechaNacFechaRef(anionac, mesnac, dianac, anioref, mesref, diaref)
      idran = -1  # id del rango en el que está e
      ransin = -1 # id del rango SIN INFORMACION
      for i, r of rangos
        if (r[0] <= e || r[0]=='') && (e <= r[1] || r[1] == '')
          idran = i
#          if idrf[i] == -1
#            sivel2_sjr_aumenta_fila_poblacion(idrf, i)
        else if r[0] == -1
          ransin = i
      if idran == -1
        idran = ransin
      
      sexo = $(this).parent().parent().parent().find('[id^=actividad_asistencia_attributes][id$=_persona_attributes_sexo]').val()
      if idran < 0
        alert('No pudo ponerse en un rango de edad')
      else
        jrs_aumenta_poblacion(idrf, sexo, idran, 1)
    )

    # Recorre listado de casos
    #debugger
    $('#actividad_casosjr').children().find('[id^=actividad_actividad_casosjr_attributes_][id*=_rangoedad]').each( (i, h) -> 
      pid = $(this).attr('id').match(/.*_([MSF])_([0-9]*)$/)
      if pid.length<3
        alert('Problema para extraer informacion de id=' + $(this).attr('id'))
      else
        sexo = pid[1]
        idran = pid[2]
        jrs_aumenta_poblacion(idrf, sexo, idran, $(this).val())
    )


