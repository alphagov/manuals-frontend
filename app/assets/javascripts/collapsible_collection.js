(function() {
  "use strict";
  window.GOVUK = window.GOVUK || {};

  function CollapsibleCollection(options){
    this.collapsibles = {};

    this.$container = options.el;
    this.markupSections();
    this.$sections = this.$container.find('.js-openable');
    this.$sections.each($.proxy(this.initCollapsible, this));

    this.$openAll = $("<a href='#' aria-hidden=true>Open all</a>"),
    this.$closeAll = $("<a href='#' aria-hidden=true>Close all</a>");
    this.addControls();

    this.closeAll();

    var openSectionID = window.location.hash.substr(1);
    if(typeof(this.collapsibles[openSectionID]) != 'undefined') {
      this.collapsibles[openSectionID].open();
    }
  }

  CollapsibleCollection.prototype.initCollapsible = function initCollapsible(sectionIndex){
    var $section = $(this.$sections[sectionIndex]);
    var collapsible = new GOVUK.Collapsible($section);
    $section.on('click', $.proxy(this.updateControls, this));
    this.collapsibles[$section.attr('data-section-id')] = collapsible;
  }

  CollapsibleCollection.prototype.markupSections = function markupSections(){
    // Pull out h2's and mark them up as subsection-title.
    // Mark all following tags up to the next h2 as subsection-body.
    // Wrap newly discovered sections in a div with js-openable and manual-subsection classes
    // The DOM now contains poperly marked up sections to which collapsible functions can attach.

    var subsectionHeaders = this.$container.find('h2').not('.linked-title, .js-ignore-h2s h2');
    subsectionHeaders.addClass('subsection-title');
    subsectionHeaders.each(function(index){
      var subsectionBody = $(this).nextUntil('h2.subsection-title, h2.linked-title');
      subsectionBody.andSelf().wrapAll('<div class="manual-subsection js-openable"></div>');
      subsectionBody.wrapAll('<div class="subsection-body"></div>');
    });
  }

  CollapsibleCollection.prototype.closeAll = function closeAll(event){
    for (var section in this.collapsibles) {
      this.collapsibles[section].close();
    }

    this.disableControl(this.$closeAll);
    this.enableControl(this.$openAll);

    if (typeof event != 'undefined'){
      event.preventDefault();
    }
  }

  CollapsibleCollection.prototype.openAll = function openAll(event){
    for (var section in this.collapsibles) {
      this.collapsibles[section].open();
    }

    this.disableControl(this.$openAll);
    this.enableControl(this.$closeAll);

    if (typeof event != 'undefined'){
      event.preventDefault();
    }
  }

  CollapsibleCollection.prototype.addControls = function addControls(){
    this.$container.find('.title-controls-wrap').append('<div class="collection-controls"></div>');
    this.$container.find('.collection-controls').append(this.$openAll);
    this.$container.find('.collection-controls').append(this.$closeAll);

    this.$openAll.on('click', $.proxy(this.openAll, this));
    this.$closeAll.on('click', $.proxy(this.closeAll, this));

  }

  CollapsibleCollection.prototype.updateControls = function updateControls(){
    // if all the sections in this collection are open
    var sectionCount = this.$sections.length;
    var closedCount = this.$container.find('.closed').length;

    if (closedCount == 0) {
      // all the sections are open
      this.disableControl(this.$openAll);
      this.enableControl(this.$closeAll);

    } else if (sectionCount == closedCount) {
      // all the sections are closed
      this.disableControl(this.$closeAll);
      this.enableControl(this.$openAll);

    } else {
      this.enableControl(this.$openAll);
      this.enableControl(this.$closeAll);
    }
  }

  CollapsibleCollection.prototype.disableControl = function disableControl(control){
    control.addClass('disabled');
  }

  CollapsibleCollection.prototype.enableControl = function enableControl(control){
    control.removeClass('disabled');
  }

  GOVUK.CollapsibleCollection = CollapsibleCollection;
}());
