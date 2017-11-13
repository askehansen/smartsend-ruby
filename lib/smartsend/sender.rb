class Smartsend::Sender < Smartsend::Address
  def serialize
    super.merge(senderid: nil)
  end
end
