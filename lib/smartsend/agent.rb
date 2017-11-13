class Smartsend::Agent < Smartsend::Address
  attr_accessor :carrier

  def serialize
    super.merge(
      id: @id,
      agentno: @id,
      agenttype: @carrier
    )
  end

end
