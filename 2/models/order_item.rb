class OrderItem

  attr_accessor :code, :name, :quantity, :price, :discount, :total_before_discount, :total_after_discount

  def initialize code, name, quantity, price, discount, total_before_discount, total_after_discount
    @code = code
    @name = name
    @quantity = quantity
    @price = price
    @discount = discount
    @total_before_discount = total_before_discount
    @total_after_discount = total_after_discount
  end

end
