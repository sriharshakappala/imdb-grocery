require_relative '../models/cart_item'

class CartService

  attr_accessor :store

  def initialize store
    @store = store
  end

  def addProductToCart cart, code, quantity
    itemInStore = store.getItemByCode code
    if itemInStore.nil?
      return -1, 'Invalid Product'
    elsif itemInStore.outOfStock?
      return -1, 'This product is out of stock'
    elsif quantity > itemInStore.quantity
      return -1, 'Requested quantity is not available'
    end
    price = itemInStore.discountedPrice * quantity
    ci = CartItem.new(itemInStore.code, itemInStore.name, quantity, price)
    cart.cart_items << ci
    itemInStore.removeStock quantity
  end

  def clearCart cart
    cart.cart_items.each do |item|
      binding.pry
      cart.clearItem item.code
      itemInStore = store.getItemByCode item.code
      itemInStore.addStock item.quantity
    end
  end

  def placeOrder cart, discount
    binding.pry
    store.orders << cart
    store.sales += cart.total
  end

end
