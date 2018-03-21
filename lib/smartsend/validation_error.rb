class Smartsend::ValidationError
  attr_accessor :links, :fields, :message

  def self.build(response)
    self.new.tap do |error|
      error.message = response['message']
      error.links = response['links']
      error.fields = response['errors']
    end
  end
end
