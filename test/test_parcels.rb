require 'minitest/autorun'
require 'smartsend'

class ParcelsTest < Minitest::Test

  def test_serializing
    parcel = Smartsend::Parcel.new(
      :shipped_at     => Time.new(2017, 11, 30, 16, 46, 04, 0),
      :reference      => '123456789',
      :weight         => 1.25,
      :height         => 21,
      :width          => 27,
      :length         => 35,
      :size           => "large",
      :items          => [],
      :freetext_lines => [
        "Brians birthsday gift",
        "Don't open this before your birthsday Brian",
        "We look forward to seeing you soon Brian"
      ]
    )

    assert_equal({
      "shipdate": Time.new(2017, 11, 30, 16, 46, 04, 0),
      "reference": "123456789",
      "weight": 1.25,
      "height": 21,
      "width": 27,
      "length": 35,
      "size": "large",
      "freetext1": "Brians birthsday gift",
      "freetext2": "Don't open this before your birthsday Brian",
      "freetext3": "We look forward to seeing you soon Brian",
      "items": []
    }, parcel.serialize)
  end

  private



end
