class Smartsend::Shipment
  attr_accessor :internal_id, :internal_reference, :shipping_carrier,
                :shipping_method, :shipping_date, :sender, :receiver, :agent,
                :parcels, :services, :sub_total_price_excluding_tax,
                :sub_total_price_including_tax, :shipping_price_excluding_tax,
                :shipping_price_including_tax, :total_price_excluding_tax,
                :total_price_including_tax, :total_tax_amount, :currency,
                :success, :label_url, :error

  def initialize(args={})
    args.each do |k, v|
      instance_variable_set "@#{k}", v
    end

    @parcels ||= []
  end

  def success?
    success
  end

  def save!(account: nil)
    response = Smartsend::Client.new(account).post('shipments/labels', self.serialize)

    if response.success?
      @success = true
      @label_url = response['data']['pdf']['link']
    elsif response['code'] == 'ValidationException'
      self.error = Smartsend::ValidationError.build(response)
    else
      raise Smartsend::UnknownError.new(response)
    end
  end

  def serialize
    {
      :internal_id                   => internal_id,
      :internal_reference            => internal_reference,
      :shipping_carrier              => shipping_carrier,
      :shipping_method               => shipping_method,
      :shipping_date                 => shipping_date,
      :sender                        => sender&.serialize,
      :receiver                      => receiver&.serialize,
      :agent                         => agent&.serialize,
      :parcels                       => parcels.map(&:serialize),
      :services                      => services&.serialize,
      :sub_total_price_excluding_tax => sub_total_price_excluding_tax,
      :sub_total_price_including_tax => sub_total_price_including_tax,
      :shipping_price_excluding_tax  => shipping_price_excluding_tax,
      :shipping_price_including_tax  => shipping_price_including_tax,
      :total_price_excluding_tax     => total_price_excluding_tax,
      :total_price_including_tax     => total_price_including_tax,
      :total_tax_amount              => total_tax_amount,
      :currency                      => currency
    }
  end

end
