require 'minitest/autorun'
require 'smartsend'

class ShipmentTest < Minitest::Test

  def test_find_label
    Smartsend.configure(
      api_token: ENV['SMARTSEND_TOKEN'],
    )

    assert_raises Smartsend::NotFoundError do
      Smartsend::Label.find_by_tracking_code('123')
    end
  end

end
