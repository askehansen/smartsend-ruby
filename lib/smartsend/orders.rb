class Smartsend::Orders
  include Enumerable
  attr_accessor :labels_url

  def initialize(*orders)
    @orders = orders
  end

  def save_all!(account: nil)
    raise Smartsend::TooManyOrdersError, "You can save a maximum of 10 orders in batch" if count > 10

    response = Smartsend::Client.new(account).post('orders', self.serialize)

    update_label_url_tracking_codes(response)

    self
  end

  def update_label_url_tracking_codes(response)
    @labels_url = response['combine_pdf']
    
    response['orders'].each do |response_order|
      if order = @orders.select { |x| x.id.to_s == response_order['reference'].to_s }.first
        order.update_label_url_tracking_codes(response_order)
      end
    end
  end

  def <<(order)
    @orders << order
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
