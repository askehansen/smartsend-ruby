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
      "notesms": @phone
    }
  end

end
