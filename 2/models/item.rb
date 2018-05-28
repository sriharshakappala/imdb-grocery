class Item

  attr_accessor :code, :name, :discount, :price, :quantity

  def initialize code, name, price, discount, quantity
    @code = code
    @name = name
    @price = price
    @discount = discount
    @quantity = quantity
  end

  def outOfStock?
    quantity == 0
  end

  def discountedPrice
    price - discount
  end

  def addStock num
    @quantity += num
  end

  def removeStock num
    @quantity -= num
  end

end
