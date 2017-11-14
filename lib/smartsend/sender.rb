class Smartsend::Sender < Smartsend::Address
  def serialize
    super.merge(senderid: @id)
  end
end
