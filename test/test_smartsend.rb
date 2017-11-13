require 'minitest/autorun'
require 'smartsend'

class SmartsendTest < Minitest::Test

  def test_configuration
    Smartsend.configure(
      api_key: 'test_key',
      email: 'test@test.com',
      license: 'test_license'
    )

    assert_equal Smartsend.api_key, 'test_key'
    assert_equal Smartsend.email, 'test@test.com'
    assert_equal Smartsend.license, 'test_license'
  end

end
