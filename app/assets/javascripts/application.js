//= require govuk_toolkit
//= require_tree ./modules

jQuery(function($) {

  "use strict";
  GOVUK.primaryLinks.init('.primary-item');

  $('.js-collapsible-collection').each(function(){
    new GOVUK.CollapsibleCollection({$el:$(this)});
  });
});
