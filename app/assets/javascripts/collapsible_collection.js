(function() {
  "use strict";
  window.GOVUK = window.GOVUK || {};

  function CollapsibleCollection(options){
    this.collapsibles = {};
    this.$sections = options.el.find('section');

    this.$sections.each($.proxy(this.initCollapsible, this));

    this.closeAll();
  }

  CollapsibleCollection.prototype.initCollapsible = function initCollapsible(sectionIndex){
    var $section = $(this.sections[sectionIndex]);
    var collapsible = new GOVUK.Collapsible($section);
    this.collapsibles[$section.attr('data-section-id')] = collapsible;
  }

  CollapsibleCollection.prototype.closeAll = function closeAll(){
    for (var sectionId in this.collapsibles) {
      this.collapsibles[sectionId].close();
    }
  }

  CollapsibleCollection.prototype.openAll = function openAll(){
    for (var sectionId in this.collapsibles) {
      this.collapsibles[sectionId].open();
    }
  }

  GOVUK.CollapsibleCollection = CollapsibleCollection;
}());
