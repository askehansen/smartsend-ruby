class Smartsend::RequestError
  attr_accessor :links, :errors, :message, :code, :id

  def self.build(response)
    self.new.tap do |error|
      error.id = response['id']
      error.code = response['code']
      error.message = response['message']
      error.links = response['links']
      error.errors = response['errors']
    end
  end
end
