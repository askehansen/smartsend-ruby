class Smartsend::Agent < Smartsend::Address
  attr_accessor :type

  def serialize
    super.merge(
      id: @id,
      agentno: @id,
      agenttype: @type
    )
  end

end
