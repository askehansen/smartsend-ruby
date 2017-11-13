require 'minitest/autorun'
require 'smartsend'

class SerivceTest < Minitest::Test

  def test_serializing
    service = Smartsend::Service.new(email: 'contact@smartsend.io', phone: '12345678')

    assert_equal({
    "notemail": "contact@smartsend.io",
    "notesms": "12345678",
    "prenote": true,
    "prenote_from": "contact@smartsend.io",
    "prenote_to": "contact@smartsend.io",
    "prenote_message": "Your order is now on the way.",
    "flex": "string",
    "waybillid": "string"
  }, service.serialize)
  end

end
