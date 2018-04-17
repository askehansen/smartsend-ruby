require 'minitest/autorun'
require 'smartsend'

class AccountTest < Minitest::Test

  def test_valid_account
    assert !Smartsend::Account.new(api_token: '123').valid?
    assert Smartsend::Account.new(api_token: ENV['SMARTSEND_TOKEN']).valid?
  end

end
