require 'table_print'
require 'pry'

class Store

  attr_accessor :name, :inventory, :open

  def initialize name, employeeDiscount, seniorCitizenDiscount
    @name = name
    @inventory = []
    @open = true
    @employeeDiscount = employeeDiscount
    @seniorCitizenDiscount = seniorCitizenDiscount
  end

  def viewInventory
    tp inventory, 'code', 'name', 'price', 'discount', 'quantity'
  end

  def viewSales
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
