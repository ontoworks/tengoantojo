describe "category select > "
  before
    html = $(fixture('category_select'))
    new_html = fixture('category_list')
  end

  before_each
    mock_request().and_return(new_html)
  end

  describe "show categories > "
    it "shows main categories by default"
      $(html).should.have_class "category-select"
      $(html).should.have_id "test-category-select"
    end

    it "shows a fixed number of categories and scrolls down the rest"
      true.should.be false
    end
  end

  describe "browse categories >"
    it "should load children categories"
      $(html).category_select({})
      link=$(html).find(".category:eq(4)")
      link.click()
      $(html).find(".category:eq(1) a").html().should.include "Gatos"
    end

    it "should leave breadcrumb"
      $(html).find(".breadcrumb li:first a").should.have_text "Animales y Mascotas"
    end
  end
end
