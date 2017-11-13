class Smartsend::Service
  attr_accessor :email, :phone

  def initialize(args={})
    args.each do |k, v|
      instance_variable_set "@#{k}", v
    end
  end

  def serialize
    {
      "notemail": @email,
      "notesms": @phone,
      "prenote": true,
      "prenote_from": "contact@smartsend.io",
      "prenote_to": "contact@smartsend.io",
      "prenote_message": "Your order is now on the way.",
      "flex": "string",
      "waybillid": "string"
    }
  end

end
