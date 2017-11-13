require 'minitest/autorun'
require 'smartsend'

class ParcelItemsTest < Minitest::Test

  def test_serializing
    parcel_item = Smartsend::ParcelItem.new(
      sku: 'ABC123',
      title: 'ABC123',
      quantity: 2,
      unit_weight: 1.25,
      unit_price: 144.5,
      currency: 'DKK'
    )

    assert_equal({
      "sku": "ABC123",
      "title": "ABC123",
      "quantity": 2,
      "unitweight": 1.25,
      "unitprice": 144.5,
      "currency": "DKK"
    }, parcel_item.serialize)
  end

end
