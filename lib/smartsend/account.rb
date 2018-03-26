class Smartsend::Account
  attr_accessor :api_token
  attr_accessor :referer

  def initialize(api_token:, referer: nil)
    @api_token = api_token
    @referer = referer
  end

  def valid?
    raise NotImplementedError
  end

end
