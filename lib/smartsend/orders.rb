class Smartsend::Orders
  include Enumerable

  def initialize(*orders)
    @orders = orders
  end

  def save_all!
    raise Smartsend::TooManyOrdersError, "You can save a maximum of 10 orders in batch" if count > 10

    Smartsend::Client.new.post('/orders', self.serialize)
  end

  def serialize
    @orders.map(&:serialize)
  end

  def each(&block)
    @orders.each do |order|
      block.call(order)
    end
  end

end
