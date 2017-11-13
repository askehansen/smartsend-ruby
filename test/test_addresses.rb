require 'minitest/autorun'
require 'smartsend'

class AddressesTest < Minitest::Test

  def test_sender_serializing
    sender = Smartsend::Sender.new(address)

    assert_equal({
      "senderid": nil,
      "company": "Smart Send",
      "name1": "Henrik Hansen",
      "name2": "C/O Vivian Hansen",
      "address1": "Willemoesgade 42",
      "address2": "3.th.",
      "zip": 2100,
      "city": "Copenhagen",
      "country": "DK",
      "sms": 12345678,
      "mail": "contact@smartsend.io"
    }, sender.serialize)
  end

  def test_reciver_serializing
    receiver = Smartsend::Receiver.new(address)

    assert_equal({
      "reciverid": 1,
      "company": "Smart Send",
      "name1": "Henrik Hansen",
      "name2": "C/O Vivian Hansen",
      "address1": "Willemoesgade 42",
      "address2": "3.th.",
      "zip": 2100,
      "city": "Copenhagen",
      "country": "DK",
      "sms": 12345678,
      "mail": "contact@smartsend.io"
    }, receiver.serialize)
  end

  def test_agent_serializing
    receiver = Smartsend::Agent.new(address.merge(type: 'PDK'))

    assert_equal({
      "id": 1,
      "agentno": 1,
      "agenttype": "PDK",
      "company": "Smart Send",
      "name1": "Henrik Hansen",
      "name2": "C/O Vivian Hansen",
      "address1": "Willemoesgade 42",
      "address2": "3.th.",
      "zip": 2100,
      "city": "Copenhagen",
      "country": "DK",
      "sms": 12345678,
      "mail": "contact@smartsend.io"
    }, receiver.serialize)
  end

  private

  def address
    {
      :id       => 1,
      :company  => "Smart Send",
      :name1    => "Henrik Hansen",
      :name2    => "C/O Vivian Hansen",
      :address1 => "Willemoesgade 42",
      :address2 => "3.th.",
      :zip      => 2100,
      :city     => "Copenhagen",
      :country  => "DK",
      :phone    => 12345678,
      :mail     => "contact@smartsend.io"
    }
  end

end
