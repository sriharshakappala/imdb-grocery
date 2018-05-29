require_relative '../models/cart_item'

class CartService

  DISCOUNT_MENU = "
    1. Store Employee
    2. Senior Citizen
    3. None
  "

  attr_accessor :store, :cart

  def initialize store, cart
    @store = store
    @cart = cart
  end

  def addProductToCart code, quantity
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

  def placeOrder
    if cart.cart_items.empty?
      return -1, 'Cart is empty'
    end
    puts DISCOUNT_MENU
    option = gets.chomp.to_i
    puts option
    binding.pry
    store.orders << cart
    store.sales += cart.total
  end

end
