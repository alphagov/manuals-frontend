describe('CollapsibleCollection', function(){
  var collectionsFromHRMCHTML, collectionsFromBlobHTML, collectionBlob, collection;

  beforeEach(function(){

    // Content comes as a single blob of markdown from the GDSAPI in the "body" field.
    collectionsFromBlobString =
      '<div class="js-collapsible-collection subsection-collection">'+
        '<div class="collapsible-subsections">'+
          '<div class="govspeak">'+
            // Some content not in a collapsible subsection
            '<p>Where the tax gets paid to the man about the thing for the other thing</p>'+
            '<p>Where the tax gets paid to the man about the thing for the other thing</p>'+
            '<p>Where the tax gets paid to the man about the thing for the other thing</p>'+
            // Three collapsible subsections
            '<h2 id="a-section-title">A section title!</h2>'+
            '<h3 id="a-sub-section-title">A subsection title!</h3>'+
            '<p>Where an employer meets the tax payable on a non-cash incentive award given to a direct</p>'+
            '<h2 id="a-second-section-title">A second section title!</h2>'+
            '<p>Where an employer meets the tax payable on a non-cash incentive award given to a direct</p>'+
            '<p>Where an employer meets the tax payable on a non-cash incentive award given to a direct</p>'+
            '<h2 id="a-third-section-title">A third section title!</h2>'+
            '<p>Where an employer meets the tax payable on a non-cash incentive award given to a direct</p>'+
            '<p>Follow this <a id="internal-link" href="#a-sub-section-title">Link to subsection in first section</a></p>'+
          '</div>'+
        '</div>'+
      '</div>';

      collectionsFromBlobHTML = $(collectionsFromBlobString);

      $('body').append(collectionsFromBlobHTML);
      collection = new GOVUK.CollapsibleCollection({$el: collectionsFromBlobHTML});
  });

  afterEach(function(){
    collectionsFromBlobHTML.remove();
  });

  var resetBody = function resetBody() {
    collectionsFromBlobHTML.remove();
    collectionsFromBlobHTML = $(collectionsFromBlobString);
    $('body').append(collectionsFromBlobHTML);
  };

  describe('CollapsibleCollection', function(){
    beforeEach(function(){
      resetBody();
    });

    it('should close all sections by default', function(){
      spyOn(GOVUK, 'getCurrentLocation').and.returnValue({
        hash: ''
      });

      var collection = new GOVUK.CollapsibleCollection({$el: collectionsFromBlobHTML});

      var sections = $.map(
        collection.collapsibles,
        function(section, index) { return section; }
      );

      var openSections = sections.filter(
        function(section) { return !section.isClosed(); }
      );

      expect(openSections.length).toBe(0);
    });

    it('should open the section linked to by the anchor in the URL', function(){
      spyOn(GOVUK, 'getCurrentLocation').and.returnValue({
        hash: '#a-second-section-title'
      });

      var collection = new GOVUK.CollapsibleCollection({$el: collectionsFromBlobHTML});

      var sections = $.map(
        collection.collapsibles,
        function(section, index) { return section; }
      );

      var openSections = sections.filter(
        function(section) { return !section.isClosed(); }
      );

      expect(openSections.length).toBe(1);
      expect(openSections[0]).toBe(collection.collapsibles['a-second-section-title']);
    });

    it('should open the section linked to by the anchor on the same page', function(){
      var collection = new GOVUK.CollapsibleCollection({$el: collectionsFromBlobHTML});

      $('#internal-link').click();

      var sections = $.map(
        collection.collapsibles,
        function(section, index) { return section; }
      );

      var openSections = sections.filter(
        function(section) { return !section.isClosed(); }
      );

      expect(openSections.length).toBe(1);
      expect(openSections[0]).toBe(collection.collapsibles['a-section-title']);
    });
  });

  describe('initCollapsible', function(){
    it ('should add control links to HTML generated from a blob', function(){
      var html = $(collectionsFromBlobString);
      expect(html.find('a.collection-control').length).toBe(0);
      var collection = new GOVUK.CollapsibleCollection({$el:html});
      expect(collection.$container.find('.js-collection-controls a').length).toBe(2);
    });

    it('should add a new object to collapsibles hash with the id from the section for blobs', function(){
      var collectionSize = Object.keys(collection.collapsibles).length;
      collection.initCollapsible(collection.$sections[0]);
      expect(Object.keys(collection.collapsibles).length).toBe(collectionSize+1);
    });
  });

  describe('markupSections', function(){
    it('should add the a js-subsection-title class to any h2s that are not excluded by js-exclude-h2s or have the link-out class for blobs', function(){
      var html = $(collectionsFromBlobString);
      var h2Count = html.find('h2').length;
      var excludedH2Count = html.find('.js-ignore-h2s h2, h2.linked-title').length
      var sectionHeaderCount = h2Count - excludedH2Count;

      expect(html.find('h2.js-subsection-title').length).toBe(0);
      var newCollection = new GOVUK.CollapsibleCollection({$el:html});
      expect(html.find('h2.js-subsection-title').length).toBe(sectionHeaderCount);
    });

    it('should wrap h2 and section in a div with the classes js-openable for blobs', function(){
      collectionsFromBlobHTML.find('h2.js-subsection-title').each(function(index){
        expect($(this).parents('.js-openable').length).toBe(1);
      });
    });

    it('should wrap all tags following a js-subsection-title h2 up to the next js-subsection-title h2 in a div with the class js-subsection-body', function(){
      collectionsFromBlobHTML.find('h2.js-subsection-title').each(function(index){
        expect($(this).next().hasClass('js-subsection-body')).toBe(true);
      });
    });
  });

  describe('calculateSuperiorsSelector', function(){
    it ('should return all the headings of that depth level or of greater priority', function(){
     expect(collection.calculateSuperiorsSelector(1)).toBe('h2,h1');
     expect(collection.calculateSuperiorsSelector(2)).toBe('h3,h2,h1');
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

