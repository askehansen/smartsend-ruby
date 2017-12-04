class Smartsend::Account
  attr_accessor :email, :license

  def initialize(email:, license:)
    @email = email
    @license = license
  end

  def valid?
    begin
      response = Smartsend::Client.new(self).get_plain('verify_user')
      response.code.to_s == '200'
    rescue Smartsend::AuthorizationError => e
      false
    end
  end

end
