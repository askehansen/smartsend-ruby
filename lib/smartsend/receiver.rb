class Smartsend::Receiver < Smartsend::Address
  def serialize
    super.merge(receiverid: @id)
  end
end
