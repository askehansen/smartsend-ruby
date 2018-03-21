require 'minitest/autorun'
require 'smartsend'

class SmartsendTest < Minitest::Test

  def test_configuration
    Smartsend.configure(
      api_token: 'test_token',
    )

    assert_equal Smartsend.api_token, 'test_token'
  end

end
