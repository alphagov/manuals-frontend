//= require govuk_toolkit
//= require_tree .

jQuery(function($) {

  "use strict";
  GOVUK.primaryLinks.init('.primary-item');

  $('.js-collapsible-collection').each(function(){
    new GOVUK.CollapsibleCollection({$el:$(this)});
  })
});
