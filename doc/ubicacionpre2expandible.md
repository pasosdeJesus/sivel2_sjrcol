
# ubicacionpre2expandible

Control para una ubicación que busca y re-utiliza ubicaciones ya registradas 
y facilita la creación de nuevas.

Puede verse su apariencia en una línea expandible a 2 y detalles de su 
funcionalidad para el usuario final en:
<https://github.com/pasosdeJesus/sivel2_sjrcol/issues/280>

En base de datos utiliza tabla ubicacionpre.  
Este control no permite añadir países, departamentos, municipios ni centro 
poblados (para modificar estos usar tablas básicas), pero si lugares 
y sitios con su latitud y longitud.

En tablas se esperan campos de la forma:
  `salidaubicacionpre_id`, `expulsionubicacionpre_id`, etc.
que sean llaves foráneas a tabla `sip_ubicacionpre`

En modelos se usan accesores que proveen
  `salida_pais_id`, `salida_departamento_id`,  etc. para eso:
```
class Sivel2Sjr::Migracion < ActiveRecord::Base

  extend ::AccesoresUbicacionpre

  accesores_ubicacionpre :salida

...
```

En controlador se convierten campos separados (estilo antiguo control
ubicación) a ubicacionpre con:

```
      (caso_params[:migracion_attributes] || []).each do |clave, mp|
        mi = Sivel2Sjr::Migracion.find(mp[:id].to_i)
        mi.salidaubicacionpre_id = Sip::Ubicacionpre::buscar_o_agregar(
          mp[:salida_pais_id], mp[:salida_departamento_id],
          mp[:salida_municipio_id], mp[:salida_clase_id],
          mp[:salida_lugar], mp[:salida_sitio], mp[:salida_tsitio_id],
          mp[:salida_latitud], mp[:salida_longitud]
        )
```

Y en lista blanca de parámetros agregar:
```
          :salida_pais_id,
          :salida_departamento_id,
          :salida_municipio_id,
          :salida_clase_id,
          :salida_latitud,
          :salida_longitud,
          :salida_lugar,
          :salida_sitio,
          :salida_tsitio_id,
          :salida_ubicacionpre_id,
```

En vistas donde se deben incrustar las 2 filas del control usar:

```
    <% htmlid=f.object && f.object.id ? f.object.id : 0 %>
    <%= render partial: 'sip/ubicacionespre/dos_filas_confecha', locals: {
      f: f,
      htmlid: "salida-#{htmlid}",
      estilogen: '',
      campofecha: :fechasalida,
      campofecha_etiqueta: 'Fecha de salida',
      campopais: :salida_pais,
      campopais_etiqueta: 'País de salida',
      campodepartamento: :salida_departamento,
      campodepartamento_etiqueta: 'Departamento de salida',
      campomunicipio: :salida_municipio,
      campomunicipio_etiqueta: 'Municipio de salida',
      idresto: 'restosalida',
      campocentropoblado: :salida_clase,
      campocentropoblado_etiqueta: 'Centro poblado de salida',
      campolugar: :salida_lugar,
      campolugar_etiqueta: 'Barrio o vereda de salida',
      campoubicacionpre_id: :salidaubicacionpre_id,
      campositio: :salida_sitio,
      campositio_etiqueta: 'Dirección o finca de salida',
      campotsitio: :salida_tsitio,
      campotsitio_etiqueta: 'Tipo de sitio de salida',
      campolatitud: :salida_latitud,
      campolatitud_etiqueta: 'Latitud',
      campolongitud: :salida_longitud,
      campolongitud_etiqueta: 'Longitud'
    } %>
```

Como deben modificarse identificaciones HTML en caso de que se agreguen
salidas dinámicamente con cocoon y manejar autocompletación y 
deshabilitación/habilitación de campos debe:
1. registrar el uso del control con la función 
   `ubicacionpre2expandible_registra`
2. cada vez que se añada una salida dinámicamente debe cambiarse la id del
   elemento HTML asignada por cocoon mediante:
```
  control = $('#ubicacionpre-salida-0').parent()
  cocoonid = control.find('[id$=fechasalida]').attr('id').split('_')[3]
  ubicacionpre2expandible_cambia_ids('salida', cocoonid)
```



