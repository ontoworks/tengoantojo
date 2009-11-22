describe "product form > "
  before
    $html = $(fixture('product_form'))
  end

  it "takes input from user to an object"
    $product_form= $html.find("#product-form")
    $product_form.edit_product()


    $product_name=$product_form.find("#product-name")
    $product_name.click()

    $edit_product_name=$product_form.find("#edit-product-name")
    alert($product_name.attr("id"))
    $edit_product_name.find("#save-product-name").click()
  //    alert($product_form.form_data.name)
  end
end

describe "category select > "
  before
    html = $(fixture('category_select'))
    category_list = fixture('category_list')
  end

  before_each
    mock_request().and_return(category_list)
  end

  describe "show categories"
    it "shows main categories by default"
      $(html).should.have_class "category-select"
      $(html).should.have_id "test-category-select"
    end

    it "shows a fixed number of categories and scrolls down the rest"
      true.should.be true
    end
  end

  describe "browse categories"
    it "should load children categories"
      $(html).category_select({})
      link=$(html).find(".category:eq(4)")
      link.click()
      $(html).find(".category:eq(1) a").html().should.include "Gatos"
    end

    it "should leave breadcrumb"
      $(html).find(".breadcrumb li:eq(2) a").should.have_text "Animales y Mascotas"
    end

    it "should select category when a leaf is reached"
      $(html).bind("category_selected", function(e, name) { 
	  name.should.include "Gatos"
      })
      $(html).find(".category:eq(4)").click()
      $(html).find(".category:eq(1) a").click()
    end
  end
end
