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
  4. View Orders
  5. View Revenue
  6. Close Store
"

def displayMenu
  puts STORE_MENU
end

store = Store.new('My Awesome Store', 10, 15)

while store.open?
  displayMenu
  input = gets.chomp.to_i
  case input
    when 1
      StoreService.new(store).loadInventory
    when 2
      store.viewInventory
    when 3
      StoreService.new(store).processBilling
    when 4
      store.viewOrders
    when 5
      store.viewSales
    when 6
      store.close
    else
      puts 'Invalid Command'
  end
end
