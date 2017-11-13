# README

A ruby wrapper for the Smartsend.io api.

Before beginning you need a Smartsend account.

## Installation

```ruby
gem install 'smartsend-ruby'
```

## Usage

### Configuring the client

```ruby
Smartsend.configure(
  api_key: 'smartsend-api-key',
  email: 'smartsend-username',
  license: 'smartsend-license-key',
  cms_system: 'Ruby on Rails',
  cms_version: '5.0.0'
)
```

### Creating an order

This creates a label.

```ruby

# initalize a new order
order = Smartsend::Order.new(
  order_number: "AC12345789",
  carrier: "postdanmark", # postdanmark/gls/bring
  method: "private",
  return: false,
  total_price: 199.75,
  shipping_price: 49,
  currency: "DKK",
  sms_notification: "12345678",
  email_notification: "contact@smartsend.io"
)

# set the receiver of the order
order.receiver = Smartsend::Receiver.new(
  id: "123456", # your internal customer id
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

# set the sender of the order
order.sender = Smartsend::Sender.new(
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

# you can ship to a droppoint by setiing an agent
order.agent = Smartsend::Agent.new(
  id: "7224", # droppoint id
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

# add one or more parcels/fulfillments to the order
parcel = Smartsend::Parcel.new(
  shipped_at: DateTime.now,
  reference: "123456789", # your internal parcel id
  weight: 1.25,
  height: 21,
  width: 27,
  length: 35,
  size: "large",
  freetext_lines: [ # you can add up to 3 lines of freetext to be printed on the label
    "Brians birthsday gift",
    "Don't open this before your birthsday Brian",
    "We look forward to seeing you soon Brian"
  ]
)

# add items to the parcel
parcel_item = Smartsend::ParcelItem.new(
  sku: "ABC123",
  title: "ABC123",
  quantity: 2,
  unit_weight: 1.25,
  unit_price: 144.5,
  currency: "DKK"
)

parcel.items = [parcel_item]
order.parcels = [parcel]

# send the order to Smartsend.io
order.save!
```

After saving an order it is updated with a url for the label pdf and tracking codes for each parcel.

```ruby
order.label_url
  => 'https://www.pacsoftonline.com/...'

order.parcels.first.tracking_code
  => '1234...'

order.parcels.first.tracking_url
  => 'https://...'
```

### Creating orders in batch

You can create up to 10 orders in batch.

```ruby
order1 = Smartsend::Order.new(...)
order2 = Smartsend::Order.new(...)

orders = Smartsend::Orders.new(order1, order2)

# send the orders to Smartsend.io
orders.save_all!

orders.first.label_url
  => 'https://www.pacsoftonline.com/...'
```
