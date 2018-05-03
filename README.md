# README

A ruby wrapper for the Smartsend.io api.

Before beginning you need a Smartsend account.

## Installation

```ruby
gem install 'smartsend-ruby'
```


## Configuration

```ruby
Smartsend.configure(
  api_token: 'smart-send-api-token'
)
```

## Usage

### Creating a shipment

This creates a label.

```ruby
# initalize a new shipment
shipment = Smartsend::Shipment.new(
  internal_id: "123123123", # your internal order id
  internal_reference: "AC12345789", # your order number
  shipping_carrier: "postnord", # postnord/gls/bring/dao
  shipping_method: "agent",
  shipping_date: "2018-02-28"
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

# optionally ship to a droppoint by setting an agent
shipment.agent = Smartsend::Agent.new(
  id: "2103", # droppoint id
  type: "PDK", # droppoint provider
  company: "Smart Send",
  name1: "Henrik Hansen",
  name2: "C/O Vivian Hansen",
  address1: "Willemoesgade 42",
  address2: "3.th.",
  zip: "2100",
  city: "Copenhagen",
  country: "DK",
  phone: "12345678",
  mail: "contact@smartsend.io"
)

# add one or more parcels/fulfillments to the shipment
parcel = Smartsend::Parcel.new(
  shipped_at: DateTime.now,
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
```

After saving, the shipment it is updated with a url for the label pdf and tracking codes for each parcel.

```ruby
shipment.label_url
  => 'http://v70.api.smartsend.dk/...'

shipment.parcels.first.tracking_code
  => '1234...'

shipment.parcels.first.tracking_url
  => 'https://tracking.postnord.com/...'
```

### Using multiple accounts

If your system requires multiple accounts you can pass an account instance when saving orders.

```ruby
shipment = Smartsend::Order.new(...)

account = Smartsend::Account.new(
  api_token: 'smartsend-api-token'
)

shipment.save!(account: account)
```

### Validating account
```ruby
account = Smartsend::Account.new(
  api_token: 'wrong-smartsend-api-token'
)

account.valid?
  => false
```

## Changelog

### [0.4.2] - 2018-05-03
* Changed `sub_total` to `subtotal`
