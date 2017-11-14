require 'minitest/autorun'
require 'smartsend'

class SerivceTest < Minitest::Test

  def test_serializing
    service = Smartsend::Service.new(email: 'contact@smartsend.io', phone: '12345678')

    assert_equal({
    "notemail": "contact@smartsend.io",
    "notesms": "12345678"
  }, service.serialize)
  end

end
