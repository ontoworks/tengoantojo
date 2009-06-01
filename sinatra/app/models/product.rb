class Product 
  attr_accesor :name, :description, :price

  def initializer(opts)
    @name=opts.delete(:name)
    @description=opts.delete(:description)
    @price=opts.delete(:price)
  end
end

class Products
  attr_writer :list

  def initializer(list)
    @list=list
  end

  def <<(o)
    @list<< o
  end

  def each
    @list.each do |p|
      yield p
    end
  end
end
