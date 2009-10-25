describe 'marketplace'
  describe 'search'
  end

  describe 'favorites'
  end

  describe 'shop'
    describe 'show products'
      it "should query Google Base for products"
        true.should.be true
      end
    end

    describe 'post new product'
      it 'should show product overlay'
        true.should.be true
      end
    end
  end
end
