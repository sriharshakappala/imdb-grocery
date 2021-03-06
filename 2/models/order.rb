require 'securerandom'

class Order

  attr_accessor :id, :order_items, :discount_type, :discount_percent

  def initialize discount_type, discount_percent
    @id = SecureRandom.uuid
    @order_items = []
    @discount_type = discount_type
    @discount_percent = discount_percent
  end

  def total
    order_items.map(&:total_after_discount).inject(0, &:+)
  end

  def totalAfterDiscount
    total - ((total * discount_percent) / 100)
  end

end
