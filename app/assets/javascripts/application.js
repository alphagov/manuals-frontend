//= require govuk_publishing_components/all_components
//= require_tree ./modules

jQuery(function($) {
  "use strict";
  GOVUK.primaryLinks.init('.primary-item');

  $('.js-collapsible-collection').each(function(){
    new GOVUK.CollapsibleCollection({$el:$(this)});
  });
});
