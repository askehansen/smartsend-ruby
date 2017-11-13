class Smartsend::Orders
  include Enumerable

  def initialize(*orders)
    @orders = orders
  end

  def save_all!
    raise Smartsend::TooManyOrdersError, "You can save a maximum of 10 orders in batch" if count > 10

    response = Smartsend::Client.new.post('orders', self.serialize)

    update_label_url_tracking_codes(response)

    self
  end

  def update_label_url_tracking_codes(response)
    response['orders'].each do |response_order|
      if order = @orders.select { |x| x.order_number.to_s == response.orderno.to_s }.first
        order.update_label_url_tracking_codes(response)
      end
    end
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
