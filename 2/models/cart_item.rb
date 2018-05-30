class CartItem

  attr_accessor :code, :name, :quantity, :price, :discount, :total_before_discount, :total_after_discount

  def initialize code, name, quantity, price, discount
    @code = code
    @name = name
    @quantity = quantity
    @price = price
    @discount = discount
    @total_before_discount = price * quantity
    @total_after_discount = (price - discount) * quantity
  end

  def addQuantity num
    @quantity += num
    @total_before_discount = price * quantity
    @total_after_discount = (price - discount) * quantity
  end

end
