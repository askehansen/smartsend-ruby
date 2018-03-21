require 'minitest/autorun'
require 'smartsend'
require 'date'

class ShipmentTest < Minitest::Test

  def test_successful_label
    Smartsend.configure(
      api_token: 'test_token',
    )

    shipment = Smartsend::Shipment.new(
      internal_id: "123123123", # your internal order id
      internal_reference: "AC12345789", # your order number
      shipping_carrier: "postnord", # postnord/gls/bring/dao
      shipping_method: "agent",
      shipping_date: Date.today.strftime('%Y-%m-%d'),
      currency: "DKK"
    )

    shipment.services = Smartsend::Services.new(
      email_notification: 'contact@smartsend.io'
    )

    # set the receiver of the shipment
    shipment.receiver = Smartsend::Receiver.new(
      internal_id: "123456", # your internal customer id
      internal_reference: "123456",
      company: "Smart Send",
      name_line1: "Henrik Hansen",
      name_line2: "C/O Vivian Hansen",
      address_line1: "Willemoesgade 42",
      address_line2: "3.th.",
      postal_code: "2100",
      city: "Copenhagen",
      country: "DK",
      sms: "12345678",
      email: "contact@smartsend.io"
    )

    # optionally set the sender of the shipment
    shipment.sender = Smartsend::Sender.new(
      internal_id: "123456",
      internal_reference: "123456",
      company: "Smart Send",
      name_line1: "Henrik Hansen",
      name_line2: "C/O Vivian Hansen",
      address_line1: "Willemoesgade 42",
      address_line2: "3.th.",
      postal_code: "2100",
      city: "Copenhagen",
      country: "DK",
      sms: "12345678",
      email: "contact@smartsend.io"
    )

    # # optionally ship to a droppoint by setting an agent
    # shipment.agent = Smartsend::Agent.new(
    #   internal_id: "123456",
    #   internal_reference: "123457",
    #   agent_no: "2103", # droppoint id
    #   company: "Smart Send",
    #   name_line1: "Henrik Hansen",
    #   name_line2: "C/O Vivian Hansen",
    #   address_line1: "Willemoesgade 42",
    #   address_line2: "3.th.",
    #   postal_code: "2100",
    #   city: "Copenhagen",
    #   country: "DK"
    # )

    # add one or more parcels/fulfillments to the shipment
    parcel = Smartsend::Parcel.new(
      internal_id: "123456789", # your internal parcel id
      internal_reference: "123456789",
      weight: 1.25,
      height: 21,
      width: 27,
      length: 35,
      freetext1: "Brians birthday gift",
      freetext2: "Don't open this before your birthday Brian",
      freetext3: "We look forward to seeing you soon Brian",
    )

    # add items to the parcel
    parcel_item = Smartsend::ParcelItem.new(
      internal_id: "ABC123",
      internal_reference: "ABC123",
      sku: "ABC123",
      name: "Product name",
      quantity: 2,
      unit_weight: 1.25
    )

    parcel.items << parcel_item
    shipment.parcels << parcel

    # send the shipment to Smartsend.io
    shipment.save!

    assert shipment.success?
    assert shipment.label_url
  end

  def test_invalid_request
    Smartsend.configure(
      api_token: 'test_token',
    )

    shipment = Smartsend::Shipment.new(
      internal_id: "123123123", # your internal order id
      internal_reference: "AC12345789", # your order number
      # shipping_carrier: "postnord", # postnord/gls/bring/dao
      # shipping_method: "agent",
      shipping_date: Date.today.strftime('%Y-%m-%d'),
      currency: 'invalid'
    )

    # set the receiver of the shipment
    shipment.receiver = Smartsend::Receiver.new(
      internal_id: "123456", # your internal customer id
      internal_reference: "123456",
      company: "Smart Send",
      name_line1: "Henrik Hansen",
      name_line2: "C/O Vivian Hansen",
      address_line1: "Willemoesgade 42",
      address_line2: "3.th.",
      postal_code: "2100",
      city: "Copenhagen",
      country: "invalid",
      sms: "12345678",
      email: "contact@smartsend.io"
    )

    # optionally set the sender of the shipment
    shipment.sender = Smartsend::Sender.new(
      internal_id: "123456",
      internal_reference: "123456",
      company: "Smart Send",
      name_line1: "Henrik Hansen",
      name_line2: "C/O Vivian Hansen",
      address_line1: "Willemoesgade 42",
      address_line2: "3.th.",
      postal_code: "2100",
      city: "Copenhagen",
      country: "DK",
      sms: "12345678",
      email: "contact@smartsend.io"
    )

    # optionally ship to a droppoint by setting an agent
    shipment.agent = Smartsend::Agent.new(
      internal_id: "123456",
      internal_reference: "123457",
      agent_no: "2103", # droppoint id
      company: "Smart Send",
      name_line1: "Henrik Hansen",
      name_line2: "C/O Vivian Hansen",
      address_line1: "Willemoesgade 42",
      address_line2: "3.th.",
      postal_code: "2100",
      city: "Copenhagen",
      country: "invalid"
    )

    # add one or more parcels/fulfillments to the shipment
    parcel = Smartsend::Parcel.new(
      internal_id: "123456789", # your internal parcel id
      internal_reference: "123456789",
      weight: 1.25,
      height: 21,
      width: 27,
      length: 35,
      freetext1: "Brians birthday gift",
      freetext2: "Don't open this before your birthday Brian",
      freetext3: "We look forward to seeing you soon Brian",
    )

    # add items to the parcel
    parcel_item = Smartsend::ParcelItem.new(
      internal_id: "ABC123",
      internal_reference: "ABC123",
      sku: "ABC123",
      name: "Product name",
      quantity: 2,
      unit_weight: 1.25
    )

    parcel.items << parcel_item
    shipment.parcels << parcel

    # send the shipment to Smartsend.io
    shipment.save!

    assert !shipment.success?
    assert_equal 5, shipment.error.errors.count
  end

end
