require_relative '../models/cart'

class StoreService

  attr_accessor :store

  BILLING_MENU = "
    1. Add product to Cart
    2. View Cart
    3. Checkout
    4. Clear Cart
    5. Exit
  "

  def initialize store
    @store = store
  end

  def loadInventory
    puts "******* Loading Item to Inventory *******"
    puts "Enter Code"
    code = gets.chomp
    item = store.getItemByCode code
    if item.nil?
      puts "Enter Name"
      name = gets.chomp
      puts "Enter Price"
      price = gets.chomp.to_i
      puts "Enter Discount"
      discount = gets.chomp.to_i
      puts "Enter Quantity"
      quantity = gets.chomp.to_i
      item = Item.new(code, name, price, discount, quantity)
      store.inventory << item
    else
      puts "Enter Quantity"
      quantity = gets.chomp.to_i
      item.quantity += quantity
    end
    puts "******* Load Success *******"
  end

  def processBilling
    cart = Cart.new
    checkout = false
    while !checkout
      puts BILLING_MENU
      input = gets.chomp.to_i
      case input
      when 1
        store.viewInventory
        puts "Enter product code to add item to cart"
        code = gets.chomp
        puts "Enter quantity to buy"
        quantity = gets.chomp.to_i
        status, error = CartService.new(store, cart).addProductToCart code, quantity
        if status == -1
          puts error
        end
      when 2
        cart.view
      when 3
        status, error = CartService.new(store, cart).placeOrder
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

end
