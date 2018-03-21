class Smartsend::Account
  attr_accessor :api_token

  def initialize(api_token:)
    @api_token = api_token
  end

  def valid?
    raise NotImplementedError
  end

end
