class CartItem

  attr_accessor :code, :name, :quantity, :price

  def initialize code, name, quantity, price
    @code = code
    @name = name
    @quantity = quantity
    @price = price
  end

  def total
    price * quantity
  end

end
