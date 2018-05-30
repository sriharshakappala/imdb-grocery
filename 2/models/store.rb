require 'table_print'
require 'pry'

class Store

  attr_accessor :name, :inventory, :open, :employeeDiscount, :seniorCitizenDiscount, :orders, :sales

  def initialize name, employeeDiscount, seniorCitizenDiscount
    @name = name
    @inventory = []
    @open = true
    @employeeDiscount = employeeDiscount
    @seniorCitizenDiscount = seniorCitizenDiscount
    @orders = []
    @sales = 0
  end

  def viewInventory
    tp inventory, 'code', 'name', 'price', 'discount', 'quantity'
  end

  def viewOrders
    orders.each do |order|
      puts "Order Number - #{order.id}"
      tp order.order_items, 'code', 'name', 'quantity', 'price', 'discount', 'total_before_discount', 'total_after_discount'
      puts 'DISCOUNT INFO'
      puts "Discount Type - #{order.discount_type}"
      puts "Discount Percent - #{order.discount_percent}"
    end
    binding.pry
  end

  def viewSales
    binding.pry
    "Today's sales is #{sales}"
  end

  def open?
    open
  end

  def close
    @open = false
  end

  def getItemByCode code
    inventory.find { |item| item.code == code }
  end

end
