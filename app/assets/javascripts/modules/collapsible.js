(function() {
  "use strict";
  window.GOVUK = window.GOVUK || {};

  function Collapsible(section){
    this.$section = section;
    this.$clickTarget = this.$section.find('.js-subsection-title');
    this.$clickTarget.on('click', this.toggle.bind(this));
    this.addToggle();

    this.$section.on('focus', '.js-subsection-body a', this.showSectionWhenLinkFocused.bind(this));
  }

  Collapsible.prototype.showSectionWhenLinkFocused = function() {
    if (this.$section.is('.closed')) {
      this.$section.toggleClass('closed');
    }
  };

  Collapsible.prototype.addToggle = function addToggle(){
    var $toggleHTML = $("<span class='js-toggle'></span>");
    this.$clickTarget.append($toggleHTML);
  };

  Collapsible.prototype.toggle = function toggle(event){
    this.$section.toggleClass('closed');
    event.preventDefault();
  };

  Collapsible.prototype.close = function close(){
    this.$section.addClass('closed');
  };

  Collapsible.prototype.open = function open(){
    this.$section.removeClass('closed');
  };

  Collapsible.prototype.isClosed = function(){
    return this.$section.hasClass('closed');
  };

  GOVUK.Collapsible = Collapsible;
}());
