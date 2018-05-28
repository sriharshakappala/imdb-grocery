class StoreService

  attr_accessor :store

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

end
