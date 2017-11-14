require 'minitest/autorun'
require 'smartsend'

class OrdersTest < Minitest::Test

  def test_serializing
    assert_equal(params, order.serialize)
  end

  def test_collection_serializing
    orders = Smartsend::Orders.new(order, order)

    assert_equal 2, orders.count
    assert_equal [params, params], orders.serialize
  end

  def test_too_many_orders_errors
    assert_raises Smartsend::TooManyOrdersError do
      Smartsend::Orders.new(*(0..10).to_a).save_all!
    end
  end

  private

  def params
    {
      orderno: 'AC12345789',
      reference: '1234567',
      carrier: 'postdanmark',
      method: 'private',
      return: false,
      totalprice: 199.75,
      shipprice: 49,
      currency: 'DKK',
      test: false,
      type: 'pdf',
      sender: nil,
      receiver: nil,
      agent: nil,
      parcels: [],
      service: { :notemail=>"contact@smartsend.io", :notesms=>"12345678" }
    }
  end

  def order
    Smartsend::Order.new(
      :id           => "1234567",
      :order_number => "AC12345789",
      :carrier      => "postdanmark",
      :method       => "private",
      :return       => false,
      :total_price   => 199.75,
      :shipping_price    => 49,
      :currency     => "DKK",
      :sms_notification => '12345678',
      :email_notification => 'contact@smartsend.io',
      sender: nil,
      receiver: nil,
      agent: nil,
      parcels: []
    )
  end

end
