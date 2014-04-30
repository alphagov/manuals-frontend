describe('CollapsibleCollection', function(){
  var collectionHTML, collection, collectionString;

  beforeEach(function(){
    collectionString =
      '<div class="js-collapsible-collection">'+
        '<section class="manual-subsection js-openable" data-section-id="EIM11205">'+
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
        '<section class="manual-subsection js-openable" data-section-id="EIM11210">'+
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
    it ('should add control links', function(){
      secondCollectionHTML = $(collectionString);
      expect(secondCollectionHTML.find('a.collection-control').length).toBe(0);
      newCollection = new GOVUK.CollapsibleCollection({el:secondCollectionHTML});
      expect(newCollection.$container.find('a.collection-control').length).toBe(2);
    });

    it('should add a new object to collapsibles hash with the id from the section', function(){
      var collectionSize = Object.keys(collection.collapsibles).length;
      collection.initCollapsible(collection.$sections[0]);
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

    it('should call disable with the closeAll control', function(){
      spyOn(collection, "disableControl");
      collection.closeAll();
      expect(collection.disableControl).toHaveBeenCalledWith(collection.$closeAll);
    });

    it('should call enable with the openAll control', function(){
      spyOn(collection, "enableControl");
      collection.closeAll();
      expect(collection.enableControl).toHaveBeenCalledWith(collection.$openAll);
    });
  });

  describe('openAll', function(){
    it('should open all collapsibles in this collection', function(){
      collection.closeAll();

      for (var collapsible_id in this.collapsibles) {
        expect($(this.collapsible[collapsible.id]).isOpen()).toBe(false)
      }
      collection.openAll();

      for (var collapsible_id in this.collapsibles) {
        expect($(this.collapsible[collapsible.id]).isClosed()).toBe(true)
      }
    });

    it('should call disable with the openAll control', function(){
      spyOn(collection, "disableControl");
      collection.openAll();
      expect(collection.disableControl).toHaveBeenCalledWith(collection.$openAll);
    });

    it('should call enable with the closeAll control', function(){
      spyOn(collection, "enableControl");
      collection.openAll();
      expect(collection.enableControl).toHaveBeenCalledWith(collection.$closeAll);
    });
  });

  describe('updateControls', function(){
    it ('should call enableControl with openAll if any of the collapsible sections are closed', function(){
      spyOn(collection, "enableControl");
      collection.collapsibles[Object.keys(collection.collapsibles)[0]].close();
      collection.collapsibles[Object.keys(collection.collapsibles)[1]].open();
      collection.updateControls();

      expect(collection.enableControl).toHaveBeenCalledWith(collection.$openAll);
    });

    it ('should call enableControl with closeAll if any of the collapsible sections are open', function(){
      spyOn(collection, "enableControl");
      collection.collapsibles[Object.keys(collection.collapsibles)[0]].close();
      collection.collapsibles[Object.keys(collection.collapsibles)[1]].open();
      collection.updateControls();

      expect(collection.enableControl).toHaveBeenCalledWith(collection.$closeAll);
    });

    it ('should call disableControl with closeAll if all of the collapsible sections are closed', function(){
      spyOn(collection, "disableControl");
      collection.closeAll();

      collection.updateControls();

      expect(collection.disableControl).toHaveBeenCalledWith(collection.$closeAll);
    });

    it ('should call disableControl with openAll if all of the collapsible sections are open', function(){
      spyOn(collection, "disableControl");
      collection.openAll();

      collection.updateControls();

      expect(collection.disableControl).toHaveBeenCalledWith(collection.$openAll);
    });

  });
});

