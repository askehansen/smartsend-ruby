class Smartsend::Orders
  include Enumerable
  attr_accessor :labels_url, :status_code, :pacsoft_link

  def initialize(*orders)
    @orders = orders
  end

  def save_all!(account: nil)
    raise Smartsend::TooManyOrdersError, "You can save a maximum of 10 orders in batch" if count > 10

    response = Smartsend::Client.new(account).post('booking/orders', self.serialize)

    @status_code = response.http_code
    if response.success?
      update_label_url_tracking_codes(response)
      self
    else
      false
    end
  end

  def update_label_url_tracking_codes(response)
    response['orders'].to_a.each do |response_order|
      if order = @orders.select { |x| x.id.to_s == response_order['reference'].to_s }.first
        order.update_label_url_tracking_codes(response_order)
      end
    end

    @pacsoft_link = response['combine_link']

    @labels_url = if @orders.one?
      @orders.first.label_url
    else
      response['combine_pdf']
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
