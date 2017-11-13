class Smartsend::Order
  attr_accessor :order_number, :carrier, :method, :return, :total_price, :shipping_price, :currency,
    :sender, :receiver, :agent, :parcels, :sms_notification, :email_notification

  def initialize(args={})
    args.each do |k, v|
      instance_variable_set "@#{k}", v
    end
  end

  def save!
    Smartsend::Client.new.post('/order', self.serialize)
  end

  def serialize
    {
      orderno: @order_number,
      carrier: @carrier,
      method: @method,
      return: @return,
      totalprice: @total_price,
      shipprice: @shipping_price,
      currency: @currency,
      test: false,
      type: 'pdf',
      sender: @sender&.serialize,
      receiver: @receiver&.serialize,
      agent: @agent&.serialize,
      parcels: @parcels.to_a.each(&:serialize),
      service: service.serialize
    }
  end

  private

  def service
    Smartsend::Service.new(phone: @sms_notification, email: @email_notification)
  end

end
