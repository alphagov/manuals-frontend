describe('CollapsibleCollection', function(){
  var collectionsFromSectionsHTML, collectionsFromBlobHTML, collectionBlob, collectionHTML, collection, collectionString;

  beforeEach(function(){
    collectionsFromBlobString =
      '<div class="js-collapsible-collection subsection-collection">'+
        '<div class="title-controls-wrap">'+
        '</div>'+
        '<div class="collapsible-subsections">'+
          // Three collapsible subsections
          '<h2>A section title!</h2>'+
          '<p>Where an employer meets the tax payable on a non-cash incentive award given to a direct</p>'+
          '<h2>A second section title!</h2>'+
          '<p>Where an employer meets the tax payable on a non-cash incentive award given to a direct</p>'+
          '<p>Where an employer meets the tax payable on a non-cash incentive award given to a direct</p>'+
          '<h2>A third section title!</h2>'+
          '<p>Where an employer meets the tax payable on a non-cash incentive award given to a direct</p>'+
        '</div>'+
      '</div>';

    collectionsFromSectionsString =
      '<div class="js-collapsible-collection subsection-collection">'+
        '<div class="title-controls-wrap"><h3 class="title">Group Title</h3></div>'+
        '<div class="collapsible-subsections">'+
          // Three collapsible subsections
          '<h2 class="subsection-with-id">'+
            '<span class="subsection-id">EIM1234</span>'+
            '<span class="subsection-title-text">Subsection title</span>'+
            '<span class="subsection-summary">Here is a concise summary of the content</span>'+
          '</h2>'+
          '<div class="js-ignore-h2s subsection-body">'
            '<h2>This h2 should be ignored by the section builder</h2>'+
            '<p>Where an employer meets the tax payable on a non-cash incentive award given to a direct</p>'+
            '<p>Where an employer meets the tax payable on a non-cash incentive award given to a direct</p>'+
          '</div>'+
          '<h2 class="subsection-with-id">'+
            '<span class="subsection-id">EIM1234</span>'+
            '<span class="subsection-title-text">Subsection title</span>'+
            '<span class="subsection-summary">Here is a concise summary of the content</span>'+
          '</h2>'+
          '<div class="js-ignore-h2s subsection-body">'
            '<h2>This h2 should be ignored by the section builder</h2>'+
            '<p>Where an employer meets the tax payable on a non-cash incentive award given to a direct</p>'+
            '<p>Where an employer meets the tax payable on a non-cash incentive award given to a direct</p>'+
          '</div>'+
          '<h2 class="subsection-with-id">'+
            '<span class="subsection-id">EIM1234</span>'+
            '<span class="subsection-title-text">Subsection title</span>'+
            '<span class="subsection-summary">Here is a concise summary of the content</span>'+
          '</h2>'+
          '<div class="js-ignore-h2s subsection-body">'
            '<h2>This h2 should be ignored by the section builder</h2>'+
            '<p>Where an employer meets the tax payable on a non-cash incentive award given to a direct</p>'+
            '<p>Where an employer meets the tax payable on a non-cash incentive award given to a direct</p>'+
          '</div>'+
          // One subsection that isn't collapsible
          '<h2 class="subsection-with-id linked-title">'+
            '<a href="#">'+
            '<span class="subsection-id">EIM1234</span>'+
            '<span class="subsection-title-text">Subsection title</span>'+
            '<span class="subsection-summary">Here is a concise summary of the content</span>'+
            '</a>'+
          '</h2>'+
        '</div>'+
      '</div>';

      collectionsFromSectionsHTML = $(collectionsFromSectionsString);
      collectionsFromBlobHTML = $(collectionsFromBlobString);

      $('body').append(collectionsFromSectionsHTML);
      collectionBlob = new GOVUK.CollapsibleCollection({el:collectionsFromSectionsHTML});

      $('body').append(collectionsFromBlobHTML);
      collectionSection = new GOVUK.CollapsibleCollection({el:collectionsFromBlobHTML});

      // Past initialisation the source of the collection (a blob keyed by "body" or an
      // array of sections) is irrelevant as markupSections() should normalise them)
      // Creating a collection object for testing where the source is not relevant
      collection = new GOVUK.CollapsibleCollection({el:collectionsFromBlobHTML});
  });

  afterEach(function(){
    collectionsFromSectionsHTML.remove();
    collectionsFromBlobHTML.remove();
  });


  describe('initCollapsible', function(){
    it ('should add control links', function(){
      // Blobs
      var blobHTML = $(collectionsFromBlobString);
      expect(blobHTML.find('a.collection-control').length).toBe(0);
      var newCollection = new GOVUK.CollapsibleCollection({el:blobHTML});
      expect(newCollection.$container.find('.collection-controls a').length).toBe(2);

      // Sections
      var sectionsHTML = $(collectionsFromSectionsString);
      expect(sectionsHTML.find('a.collection-control').length).toBe(0);
      newCollection = new GOVUK.CollapsibleCollection({el:sectionsHTML});
      expect(newCollection.$container.find('.collection-controls a').length).toBe(2);
    });

    it('should add a new object to collapsibles hash with the id from the section', function(){
      // Blobs
      var collectionSize = Object.keys(collectionBlob.collapsibles).length;
      collectionBlob.initCollapsible(collection.$sections[0]);
      expect(Object.keys(collectionBlob.collapsibles).length).toBe(collectionSize+1);

      // Sections
      collectionSize = Object.keys(collectionSection.collapsibles).length;
      collectionSection.initCollapsible(collectionSection.$sections[0]);
      expect(Object.keys(collectionSection.collapsibles).length).toBe(collectionSize+1);
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

