require 'pry'

require './models/cart'
require './models/item'
require './models/store'

require './services/cart_service'
require './services/store_service'

STORE_MENU = "
  1. Load Inventory
  2. View Inventory
  3. Billing
  4. View Sales
  5. Close Store
"

BILLING_MENU = "
  1. Add product to Cart
  2. View Cart
  3. Checkout
  4. Clear Cart
  5. Exit
"

store = Store.new('My Awesome Store', 10, 15)

def displayMenu
  puts STORE_MENU
end

def billingProcess store
  cart = Cart.new
  checkout = false
  while !checkout
    puts BILLING_MENU
    input = gets.chomp.to_i
    case input
    when 1
      store.viewInventory
      puts "Enter product to buy"
      code = gets.chomp
      puts "Enter quantity to buy"
      quantity = gets.chomp.to_i
      status, error = CartService.new(store).addProductToCart cart, code, quantity
      if status == -1
        puts error
      end
    when 2
      cart.view
    when 3
      puts DISCOUNT_MENU
      discountType = gets.chomp.to_i
      status, error = CartService.new(store).placeOrder cart, discountType
      if status == -1
        puts error
      end
    when 4
      CartService.new(store).clearCart cart
    when 5
      status, error = CartService.new(store).clearCart cart
      checkout = true
    else
      puts 'Invalid Command'
    end
  end
end

while store.open?
  displayMenu
  input = gets.chomp.to_i
  case input
    when 1
      StoreService.new(store).loadInventory
    when 2
      store.viewInventory
    when 3
      # billingProcess store
      StoreService.new(store).processBilling
    when 4
      store.viewOrders
    when 5
      store.close
    else
      puts 'Invalid Command'
  end
end
