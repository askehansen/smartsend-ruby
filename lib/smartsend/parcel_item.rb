class Smartsend::ParcelItem
  attr_accessor :internal_id, :internal_reference, :sku, :name, :description,
                :hs_code, :country_of_origin, :image_url, :unit_weight,
                :unit_price_excluding_tax, :unit_price_including_tax, :quantity,
                :total_price_excluding_tax, :total_price_including_tax,
                :total_tax_amount

  def initialize(args={})
    args.each do |k, v|
      instance_variable_set "@#{k}", v
    end
  end

  def serialize
    {
      :internal_id               => internal_id,
      :internal_reference        => internal_reference,
      :sku                       => sku,
      :name                      => name,
      :description               => description,
      :hs_code                   => hs_code,
      :country_of_origin         => country_of_origin,
      :image_url                 => image_url,
      :unit_weight               => unit_weight,
      :unit_price_excluding_tax  => unit_price_excluding_tax,
      :unit_price_including_tax  => unit_price_including_tax,
      :quantity                  => quantity,
      :total_price_excluding_tax => total_price_excluding_tax,
      :total_price_including_tax => total_price_including_tax,
      :total_tax_amount          => total_tax_amount,
    }
  end

end
