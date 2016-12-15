// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require dropzone
//= require bootstrap-datepicker
//= require turbolinks
//= require_tree .

 
document.addEventListener("turbolinks:load", function() {
  // Auto upload profile avatar when a image was selected 
  // from the file system
  $('#profile_avatar').change(function() {
    $('.edit_profile').submit();
  });

  $('.fotorama').fotorama();

  $('.datepicker').datepicker({
    format: 'dd/mm/yyyy',
    startDate: '1d'
  });

});







