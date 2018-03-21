module Smartsend

  @@api_token = nil

  def self.configure(args={})
    args.each do |k, v|
      class_variable_set "@@#{k}", v
    end
  end

  def self.account
    Smartsend::Account.new(api_token: @@api_token)
  end

  def self.api_token
    @@api_token
  end

  class MissingConfigError < StandardError
  end

  class AuthorizationError < StandardError
  end

  class UnknownError < StandardError
  end

  class NotFoundError < StandardError
  end

end

require_relative 'smartsend/shipment'
require_relative 'smartsend/address'
require_relative 'smartsend/receiver'
require_relative 'smartsend/sender'
require_relative 'smartsend/agent'
require_relative 'smartsend/services'
require_relative 'smartsend/parcel'
require_relative 'smartsend/parcel_item'
require_relative 'smartsend/client'
require_relative 'smartsend/account'
require_relative 'smartsend/version'
require_relative 'smartsend/validation_error'
