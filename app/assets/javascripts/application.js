//= require govuk_toolkit
//= require_tree ./modules
//= require govuk_publishing_components/components/feedback

jQuery(function($) {

  "use strict";
  GOVUK.primaryLinks.init('.primary-item');

  $('.js-collapsible-collection').each(function(){
    new GOVUK.CollapsibleCollection({$el:$(this)});
  });
});
