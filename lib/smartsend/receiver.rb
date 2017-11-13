class Smartsend::Receiver < Smartsend::Address
  def serialize
    super.merge(reciverid: @id)
  end
end
