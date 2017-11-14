class Smartsend::Account
  attr_accessor :email, :license

  def initialize(email:, license:)
    @email = email
    @license = license
  end

end
