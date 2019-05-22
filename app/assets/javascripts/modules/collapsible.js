(function() {
  "use strict";
  window.GOVUK = window.GOVUK || {};

  function Collapsible(section){
    this.$section = section;
    this.$clickTarget = this.$section.find('.js-subsection-title');
    this.$button = this.$section.find('.js-section-button')[0];

    this.$clickTarget.on('click', this.handleClick.bind(this));
    this.addToggle();
    this.$section.on('focus', '.js-subsection-body a', this.showSectionWhenLinkFocused.bind(this));
  }

  Collapsible.prototype.handleClick = function handleClick(){
    this.toggle()
    this.updateAriaAttribute(this.$button)
  };

  Collapsible.prototype.updateAriaAttribute = function updateAriaAttribute($button, state){
    if (state) {
      $button.setAttribute('aria-expanded', state);
    } else {
      $button.getAttribute('aria-expanded') === 'false' ?  $button.setAttribute('aria-expanded', 'true') : $button.setAttribute('aria-expanded', 'false');
    }
  };

  Collapsible.prototype.showSectionWhenLinkFocused = function showSectionWhenLinkFocused() {
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
  };

  Collapsible.prototype.open = function open(){
    this.$section.removeClass('closed');
  };

  Collapsible.prototype.isClosed = function isClosed(){
    return this.$section.hasClass('closed');
  };

  GOVUK.Collapsible = Collapsible;
}());
