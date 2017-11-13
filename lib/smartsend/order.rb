class Smartsend::Order
  attr_accessor :id, :label_url, :order_number, :carrier, :method, :return, :total_price, :shipping_price, :currency,
    :sender, :receiver, :agent, :parcels, :sms_notification, :email_notification

  def initialize(args={})
    args.each do |k, v|
      instance_variable_set "@#{k}", v
    end
  end

  def save!
    response = Smartsend::Client.new.post('order', self.serialize)

    update_label_url_tracking_codes(response)

    self
  end

  def update_label_url_tracking_codes(response)
    @id = response['id']
    @label_url = response['link']

    response['parcels'].each do |parcel_response|
      if parcel = @parcels.select { |x| x.reference.to_s == parcel_response['reference'].to_s }.first
        parcel.tracking_code = parcel_response['tracecode']
        parcel.tracking_url = parcel_response['tracelink']
      end
    end
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
      parcels: @parcels.to_a.map(&:serialize),
      service: service.serialize
    }
  end

  private

  def service
    Smartsend::Service.new(phone: @sms_notification, email: @email_notification)
  end

end
