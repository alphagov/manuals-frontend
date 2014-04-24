describe('CollapsibleCollection', function(){
  var collectionHTML, collection;

  beforeEach(function(){
    var collectionString =
      '<div class="js-collapsible-collection">'+
        '<section class="manual-subsection closed" data-section-id="EIM11205">'+
          '<div class="subsection-title">'+
            '<span class="subsection-id ">EIM11205</span>'+
            '<h4 id="EIM11205">'+
              '<a href="#EIM11205">Tax liability on incentive awards</a>'+
            '</h4>'+
          '</div>'+
          '<div class="subsection-body govspeak">'+
            '<h5>General</h5>'+
            '<p>Where an employer meets the tax payable on a non-cash incentive award given to a direct employee by entering into a PAYE settlement agreement (PSA), the award is not chargeable to tax on the employee. PSAs cannot be used to pay the tax on cash incentive awards. PSAs are covered at EIM11270.</p>'+
          '</div>'+
        '</section>'+
        '<section class="manual-subsection closed" data-section-id="EIM11210">'+
          '<div class="subsection-title">'+
            '<span class="subsection-id ">EIM11210</span>'+
            '<h4 id="EIM11210">'+
              '<a href="#EIM11210">Awards to an employees family or dependants</a>'+
            '</h4>'+
          '</div>'+
          '<div class="subsection-body govspeak">'+
            '<h5>Sections 74, 83, 91, 721(4) and 721(5) ITEPA 2003</h5>'+
            '<p>Awards are treated as made to the employee if they are received by members of the employees family or household. There are different definitions of the family circle depending upon whether vouchers are used, or awards are obtained in some other way and are chargeable under the benefits code.</p>'+
          '</div>'+
        '</section>'+
      '</div>';

      collectionHTML = $(collectionString);
      $('body').append(collectionHTML);
      collection = new GOVUK.CollapsibleCollection({el:collectionHTML});
  });

  afterEach(function(){
    collectionHTML.remove();
  });


  describe('initCollapsible', function(){

    it('should add a new object to collapsibles hash with the id from the section', function(){
      var collectionSize = Object.keys(collection.collapsibles).length;
      collection.initCollapsible(collection.sections[0]);
      expect(Object.keys(collection.collapsibles).length).toBe(collectionSize+1);
    });
  });

  describe('closeAll', function(){
    it('should close all collapsibles in this collection', function(){
      collection.openAll();

      for (var collapsible_id in this.collapsibles) {
        expect($(this.collapsible[collapsible.id]).isClosed()).toBe(false)
      }
      collection.closeAll();

      for (var collapsible_id in this.collapsibles) {
        expect($(this.collapsible[collapsible.id]).isClosed()).toBe(true)
      }
    });
  });
});

