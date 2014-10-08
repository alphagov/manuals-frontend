describe('Collapsible', function(){

  var collapsible, collapsibleHTML;

  beforeEach(function(){
    var collapsibleString = '<section class="closed" data-section-id="EIM11210">'+
      '<div class="js-subsection-title">'+
        '<span class="subsection-id ">EIM11210</span>'+
        '<h4 id="EIM11210">'+
          '<a href="#EIM11210">Awards to an employees family or dependants</a>'+
        '</h4>'+
      '</div>'+
      '<div class="js-subsection-body govspeak">'+
        '<h5>Sections 74, 83, 91, 721(4) and 721(5) ITEPA 2003</h5>'+
        '<p>Awards are treated as made to the employee if they are received by members of the employees family or household. There are different definitions of the family circle depending upon whether vouchers are used, or awards are obtained in some other way and are chargeable under the benefits code.</p>'+
      '</div>'+
    '</section>';

    collapsibleHTML = $(collapsibleString);
    $('body').append(collapsibleHTML);
    collapsible = new GOVUK.Collapsible(collapsibleHTML);
  });

  afterEach(function(){
    collapsibleHTML.remove();
  });

  describe('close', function(){
    it('should remove the class closed from the collapsible', function(){
      collapsible.open();
      expect(collapsible.isClosed()).toBe(false);
      collapsible.close();
      expect(collapsible.isClosed()).toBe(true);
    });
  });

  describe('open', function(){
    it('should remove the class closed from the collapsible', function(){
      collapsible.close();
      expect(collapsible.isClosed()).toBe(true);
      collapsible.open();
      expect(collapsible.isClosed()).toBe(false);
    });
  });

  describe('toggle', function(){
    it('should open the collapsible when it is closed', function(){
      collapsible.close();
      expect(collapsible.isClosed()).toBe(true);
      var event = new $.Event('click');
      collapsible.toggle(event);
      expect(collapsible.isClosed()).toBe(false);
    });

    it('should close the collapsible when it is opened', function(){
      collapsible.open();
      expect(collapsible.isClosed()).toBe(false);
      var event = new $.Event('click');
      collapsible.toggle(event);
      expect(collapsible.isClosed()).toBe(true);
    });
  });

  describe('isClosed', function(){
    it('should return true if the collapsible has the class "closed"', function(){
      collapsible.$section.addClass('closed');
      expect(collapsible.isClosed()).toBe(true)
    });

    it('should return false if the collapsible doesnt have the class "closed"', function(){
      collapsible.$section.removeClass('closed');
      expect(collapsible.isClosed()).toBe(false)
    });

  });
});

