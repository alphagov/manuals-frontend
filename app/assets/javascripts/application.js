//= require govuk_toolkit
//= require_tree .

jQuery(function($) {

  "use strict";
  GOVUK.primaryLinks.init('.primary-item');

  $('.js-collapsible-collection').each(function(){
    new GOVUK.CollapsibleCollection({$el:$(this)});
  })

  if (window.location.hash) {
    openSectionContainingAnchor($(window.location.hash));
  }

  $('.govspeak').on('click', 'a', function(event){
    if (window.location.pathname == event.target.pathname) {
      openSectionContainingAnchor($(event.currentTarget.hash));
    }
  })
});


function openSectionContainingAnchor($anchor) {
  if ($anchor.length != 0) {
    new GOVUK.Collapsible($anchor.closest('.js-openable')).open();
  }
}
