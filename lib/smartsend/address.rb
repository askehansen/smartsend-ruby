class Smartsend::Address
  attr_accessor :internal_id, :internal_reference, :company, :name_line1,
                :name_line2, :address_line1, :address_line2, :postal_code,
                :city, :country, :sms, :email

  def initialize(args={})
    args.each do |k, v|
      instance_variable_set "@#{k}", v
    end
  end

  def serialize
    {
      :internal_id        => internal_id,
      :internal_reference => internal_reference,
      :company            => company,
      :name_line1         => name_line1,
      :name_line2         => name_line2,
      :address_line1      => address_line1,
      :address_line2      => address_line2,
      :postal_code        => postal_code,
      :city               => city,
      :country            => country,
      :sms                => sms,
      :email              => email
    }
  end

end
