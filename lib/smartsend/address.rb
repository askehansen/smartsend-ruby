class Smartsend::Address
  attr_accessor :id, :company ,:name1 ,:name2 ,:address1 ,:address2 ,:zip ,:city ,:country ,:phone ,:mail

  def initialize(args={})
    args.each do |k, v|
      instance_variable_set "@#{k}", v
    end
  end

  def serialize
    {
      :company  => @company,
      :name1    => @name1,
      :name2    => @name2,
      :address1 => @address1,
      :address2 => @address2,
      :zip      => @zip,
      :city     => @city,
      :country  => @country,
      :sms      => @phone,
      :mail     => @mail
    }
  end

end
