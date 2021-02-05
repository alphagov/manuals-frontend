//= require govuk_publishing_components/lib
//= require govuk_publishing_components/components/accordion
//= require govuk_publishing_components/components/button
//= require govuk_publishing_components/components/feedback
//= require govuk_publishing_components/components/govspeak
//= require_tree ./modules

jQuery(function ($) {
  'use strict'
  GOVUK.primaryLinks.init('.primary-item')

  $('.js-collapsible-collection').each(function () {
    new GOVUK.CollapsibleCollection({ $el: $(this) }) // eslint-disable-line no-new
  })
})
