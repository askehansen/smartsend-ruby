class Smartsend::ParcelItem
  attr_accessor :sku, :title, :quantity, :unit_weight, :unit_price, :currency

  def initialize(args={})
    args.each do |k, v|
      instance_variable_set "@#{k}", v
    end
  end

  def serialize
    {
      :sku        => @sku,
      :title      => @title,
      :quantity   => @quantity,
      :unitweight => @unit_weight,
      :unitprice  => @unit_price,
      :currency   => @currency
    }
  end

end
