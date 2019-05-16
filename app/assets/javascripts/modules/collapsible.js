(function() {
  "use strict";
  window.GOVUK = window.GOVUK || {};

  function Collapsible(section){
    this.$section = section;
    this.$clickTarget = this.$section.find('.js-subsection-title');
    this.$clickTarget.on('click', this.handleClick.bind(this));
    this.$button = this.$clickTarget[0].querySelector('button');
    this.addToggle();

    this.$section.on('focus', '.js-subsection-body a', this.showSectionWhenLinkFocused.bind(this));
  }

  Collapsible.prototype.handleClick = function handleClick(){
    this.toggle()
    this.toggleAriaExpanded()
  };

  Collapsible.prototype.toggleAriaExpanded = function toggleAriaExpanded() {
    this.$button.getAttribute('aria-expanded') === 'false' ?  this.$button.setAttribute('aria-expanded', 'true') : this.$button.setAttribute('aria-expanded', 'false');
  };

  Collapsible.prototype.showSectionWhenLinkFocused = function() {
    if (this.$section.is('.closed')) {
      this.$section.toggleClass('closed');
    }
  };

  Collapsible.prototype.addToggle = function addToggle(){
    var $toggleHTML = $("<span class='js-toggle' aria-hidden='true'></span>");
    this.$clickTarget.append($toggleHTML);
  };

  Collapsible.prototype.toggle = function toggle(){
    this.$section.toggleClass('closed');
  };

  Collapsible.prototype.close = function close(){
    this.$section.addClass('closed');
    this.$button.setAttribute('aria-expanded', 'false');
  };

  Collapsible.prototype.open = function open(){
    this.$section.removeClass('closed');
    this.$button.setAttribute('aria-expanded', 'true');
  };

  Collapsible.prototype.isClosed = function(){
    return this.$section.hasClass('closed');
  };

  GOVUK.Collapsible = Collapsible;
}());
