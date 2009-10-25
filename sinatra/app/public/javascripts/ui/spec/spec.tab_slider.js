describe 'tab slider'
  before_each
    html = $(fixture('tab_slider'))
  end

  it "should work as a jQuery plugin"    
    var component = new $(html).localScroll()
    component.should.not_be undefined
  end

  it "should go to slide"
    true.should.be false
  end

  it "should go to next slide"
    true.should.be false
  end

  it "should go to previous slide"
    true.should.be false
  end

  it "before going to slide"
    true.should.be false
  end

end

