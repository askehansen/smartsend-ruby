class Smartsend::Services
  attr_accessor :email_notification, :sms_notification, :flex_delivery

  def initialize(args={})
    args.each do |k, v|
      instance_variable_set "@#{k}", v
    end
  end

  def serialize
    {
      :email_notification => email_notification,
      :sms_notification   => sms_notification,
      :flex_delivery      => flex_delivery
    }
  end

end
