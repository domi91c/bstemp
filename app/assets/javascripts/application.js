// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require turbolinks
//= require tether/dist/js/tether
//= require bootstrap-sprockets
//= require rails.validations

//= require_tree .

//// slide out search
var sliBtn = '.nav-search-icon',
    sliCont = '.search-slide',
    sliTxt = '.search-slide input[type=text]',
    sliDis = '.search-close',
    sliSpd = 300;

$(sliBtn).click(function() {
  $(sliCont).animate(
      { 'width': '15.5625em' }, sliSpd
  );
  $(sliTxt).focus();
});
$(sliDis).click(function() {
  $(sliCont).animate(
      { 'width': 0 }, sliSpd
  );
});

$('.pull-down').each(function() {
  var $this = $(this);
  $this.css('margin-top', $this.parent().height() - $this.height())
});
