//= require_tree .

jQuery(function($) {
  $('.js-collapsible-collection').each(function(){
    new GOVUK.CollapsibleCollection({el:$(this)});
  })
});
