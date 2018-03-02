//= require_tree ./modules
//= require govuk_publishing_components/components/feedback
// from govuk_frontend_toolkit and not delivered by static as part of
// header-footer-only on deployed environments
//= require govuk/primary-links

jQuery(function($) {
  "use strict";
  GOVUK.primaryLinks.init('.primary-item');

  $('.js-collapsible-collection').each(function(){
    new GOVUK.CollapsibleCollection({$el:$(this)});
  });
});
