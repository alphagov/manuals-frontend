//= require_tree .

jQuery(function($) {
  $('.js-collapsible-collection').each(function(){
    new GOVUK.CollapsibleCollection({el:$(this)});
  })

  $('.govspeak').on('click', 'a', function(event){
    if (window.location.pathname == event.target.pathname) {
      $section = $(event.target.hash);
      if (typeof(section) != undefined) {
        new GOVUK.Collapsible($section).open();
        event.stopPropagation();
      }
    }
  })
});
