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
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require cocoon
//= require moment
//= require bootstrap-datetimepicker
//= require pickers
//= require ckeditor/init
//= require_tree .
//= require_self

        var $_GET = {};
var junior_shown = false;
$(document).ready(function() 
    { 
		document.location.search.replace(/\??(?:([^=]+)=([^&]*)&?)/g, function () {
		    function decode(s) {
		        return decodeURIComponent(s.split("+").join(" "));
		    }

		    $_GET[decode(arguments[1])] = decode(arguments[2]);
		});
        $(".tablesorter").tablesorter(); 
        $("#junior_toggle").click(function(){
        	alert('Hi');
        	// if(junior_shown){
        	// 	$('.step.kore').show();
	        // 	$('.step.junior').hide();
	        // 	junior_shown = false;
	        // }else{
	        // 	$('.step.kore').hide();
	        // 	$('.step.junior').show();
	        // 	junior_shown = true;
	        // }
			if($_GET["junior"]=="true")
				window.location = "?junior=false"
			else
				window.location = "?junior=true"
        });



     
	$(document).keyup(function(e) { 
		if (e.keyCode == 27) {
			window.location.href = "#/CTF"
		}
	});
}); 
