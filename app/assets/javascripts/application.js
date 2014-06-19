//= require govuk_toolkit
//= require_tree .

jQuery(function($) {

  "use strict";
  GOVUK.primaryLinks.init('.primary-item');

  $('.js-collapsible-collection').each(function(){
    new GOVUK.CollapsibleCollection({$el:$(this)});
  })

  $('.govspeak').on('click', 'a', function(event){
    if (window.location.pathname == event.target.pathname) {
      var $section = $(event.target.hash);
      if ($section.length != 0) {
        new GOVUK.Collapsible($section).open();
      }
    }
  })
});
