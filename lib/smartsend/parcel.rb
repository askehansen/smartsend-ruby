class Smartsend::Parcel
  attr_accessor :internal_id, :internal_reference, :weight, :height, :width,
                :length, :freetext1, :freetext2, :freetext3,
                :total_price_excluding_tax, :total_price_including_tax,
                :total_tax_amount, :items

  def initialize(args={})
    args.each do |k, v|
      instance_variable_set "@#{k}", v
    end

    @items ||= []
  end

  def serialize
    {
      :internal_id               => internal_id,
      :internal_reference        => internal_reference,
      :weight                    => weight,
      :height                    => height,
      :width                     => width,
      :length                    => length,
      :freetext1                 => freetext1,
      :freetext2                 => freetext2,
      :freetext3                 => freetext3,
      :total_price_excluding_tax => total_price_excluding_tax,
      :total_price_including_tax => total_price_including_tax,
      :total_tax_amount          => total_tax_amount,
      :items                     => items.map(&:serialize)
    }
  end

end
