require 'table_print'
require 'pry'

class Cart

  attr_accessor :cart_items

  def initialize
    @cart_items = []
  end

  def view
    tp cart_items, 'code', 'name', 'price', 'quantity'
  end

  def total
    cart_items.map(&:price).inject(0, &:+)
  end

  def clear
    @cart_items = []
  end

  def clearItem code
    @cart_items.delete_if { |ci| ci.code == code }
  end

end
