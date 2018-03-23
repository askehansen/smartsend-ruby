class Smartsend::Shipment
  attr_accessor :internal_id, :internal_reference, :shipping_carrier,
                :shipping_method, :shipping_date, :sender, :receiver, :agent,
                :parcels, :services, :sub_total_price_excluding_tax,
                :sub_total_price_including_tax, :shipping_price_excluding_tax,
                :shipping_price_including_tax, :total_price_excluding_tax,
                :total_price_including_tax, :total_tax_amount, :currency,
                :success, :error, :labels_url

  def initialize(args={})
    args.each do |k, v|
      instance_variable_set "@#{k}", v
    end

    @parcels ||= []
  end

  def success?
    success
  end

  def save_and_create_label!(account: nil)
    response = Smartsend::Client.new(account).post('shipments/labels', self.serialize)

    if response.success?
      @success = true
      @labels_url = response.dig('data', 'pdf', 'link')

      response['data']['parcels'].each do |parcel_response|
        parcel = parcels.find do |item|
          item.internal_id == parcel_response['parcel_internal_id']
        end

        parcel&.label_url = parcel_response.dig('pdf', 'link')
        parcel&.tracking_code = parcel_response['tracking_code']
        parcel&.tracking_link = parcel_response['tracking_link']

      end
    else
      self.error = Smartsend::RequestError.build(response)
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
