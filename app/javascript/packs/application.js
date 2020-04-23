/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
console.log('Hola Mundo desde Webpacker')

require('@rails/ujs').start()   // Javascript no intrusivo segun rails
require('turbolinks').start()   // Acelera carga de paginas

import {$, jQuery} from 'jquery';
import 'popper.js'              // Dialogos emergentes usados por bootstrap
import 'bootstrap'              // Maquetacion y elementos de diseño
import 'chosen-js/chosen.jquery';       // Cuadros de seleccion potenciados
import 'bootstrap-datepicker'
import 'bootstrap-datepicker/dist/locales/bootstrap-datepicker.es.min.js'
import 'jquery-ui'
import 'jquery-ui/ui/widgets/autocomplete'
import 'jquery-ui/ui/data'
import 'jquery-ui/ui/focusable'

var L = require('leaflet')
var mc= require('leaflet.markercluster')
document.addEventListener('change', 
  function (event) {
    var m = event.target.id.match(/^caso_migracion_attributes_([0-9]*)_perfilmigracion_id$/)
    if (m != null) {
      var pd = document.getElementById('caso_migracion_attributes_'+m[1]+
        '_destino_pais_id').parentElement;
      var dd = document.getElementById('caso_migracion_attributes_'+m[1]+
        '_destino_departamento_id').parentElement;
      var md = document.getElementById('caso_migracion_attributes_'+m[1]+
        '_destino_municipio_id').parentElement;
      var cd = document.getElementById('caso_migracion_attributes_'+m[1]+
        '_destino_clase_id').parentElement;
      debugger
      if (event.target.checked) {
        pd.style.display = 'none'
        dd.style.display = 'none'
        md.style.display = 'none'
        cd.style.display = 'none'
      } else {
        pd.style.display = ''
        dd.style.display = ''
        md.style.display = ''
        cd.style.display = ''
      }
      
    }
  }
)
