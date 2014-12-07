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
//= require sivel2_sjr/application
//= require_tree .

jQuery.ajaxSetup({
	beforeSend: function(xhr) {
		$('#spinner').show();
	},
	// runs after AJAX requests complete, successfully or not
	complete: function(xhr, status) {
		$('#spinner').hide();
	}
});
