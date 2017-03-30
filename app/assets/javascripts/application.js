// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require sip/motor
//= require sivel2_gen/motor
//= require sivel2_sjr/motor
//= require cor1440_gen/motor
//= require sal7711_web/motor
//= require chartkick
//= require_tree .

$(document).on('turbolinks:load ready page:load', function() {
	var root;
	root = typeof exports !== "undefined" && exports !== null ? 
		exports : window;
	sip_prepara_eventos_comunes(root);

	// Antes de iniciar motor sivel2_gen ponemos este, para que se ejecute antes del incluido en ese motor
	$(document).on('change', 
			'[id^=caso_victima_attributes][id$=persona_attributes_anionac]', function(event) {
				debugger;

		root = typeof exports !== "undefined" && exports !== null ? 
			exports : window;
		anionac = $(this).val();
		prefIdVic = $(this).attr('id').slice(0, -27)
		r = $("[id=" + prefIdVic + "_rangoedadactual_id]")
		prefIdPer = $(this).attr('id').slice(0, -8)
		ponerVariablesEdad(root)
		if (anionac != '')  {
			edadActual = edadDeFechaNac(prefIdPer, 
					root.anioactual, root.mesactual, 
					root.diaactual)
			if (edadActual != '') {
				rid = buscarRangoEdad(+edadActual); 
				r.val(rid)
			}
		}
		r.prop('disabled', true)
	});


	sivel2_gen_prepara_eventos_comunes(root,'antecedentes/causas');
	sivel2_sjr_prepara_eventos_comunes(root);
	cor1440_gen_prepara_eventos_comunes(root);
	sal7711_gen_prepara_eventos_comunes(root);
	sivel2_sjr_prepara_eventos_unicos(root);

	$(document).on('click', 'input[data-enviarautomatico]', function(e) {
		e.preventDefault();
		enviarautomatico_formulario(root, $(e.target.form));
	});


});

/*jQuery.ajaxSetup({
	beforeSend: function(xhr) {
		$('#spinner').show();
	},
	// runs after AJAX requests complete, successfully or not
	complete: function(xhr, status) {
		$('#spinner').hide();
	}
}); */
