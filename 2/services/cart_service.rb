require './models/cart_item'
require './models/order'
require './models/order_item'

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
    itemInCart = cart.getItemByCode code
    if itemInCart.nil?
      ci = CartItem.new(itemInStore.code, itemInStore.name, quantity, itemInStore.price, itemInStore.discount)
      cart.cart_items << ci
    else
      itemInCart.addQuantity quantity
    end
    itemInStore.removeStock quantity
  end

  def clearCart
    cart.cart_items.each do |item|
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
    discountType, discountPercent = getdiscountProperties option
    order = Order.new(discountType, discountPercent)
    cart.cart_items.each do |i|
      order.order_items << OrderItem.new(
        i.code, i.name, i.quantity, i.price, i.discount, i.total_before_discount, i.total_after_discount
      )
    end
    store.orders << order
    store.sales += order.totalAfterDiscount
  end

  private

  def getdiscountProperties option
    if option == 1
      return 'Employee', store.employeeDiscount
    elsif option == 2
      return 'Senior Citizen', store.seniorCitizenDiscount
    elsif option == 3
      return 'None', 0
    end
  end

end
