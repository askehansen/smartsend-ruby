module Smartsend

  @@api_key = nil
  @@email = nil
  @@license = nil
  @@cms_system = nil
  @@cms_version = nil
  @@test_mode = false

  def self.configure(args={})
    args.each do |k, v|
      class_variable_set "@@#{k}", v
    end
  end

  def self.account
    Smartsend::Account.new(email: @@email, license: @@license)
  end

  def self.api_key
    @@api_key
  end

  def self.email
    @@email
  end

  def self.license
    @@license
  end

  def self.cms_system
    @@cms_system
  end

  def self.cms_version
    @@cms_version
  end

  def self.app_version
    Smartsend::VERSION
  end

  def self.test_mode
    @@test_mode
  end

  def self.test?
    test_mode
  end


  class TooManyOrdersError < StandardError
  end

  class MissingConfigError < StandardError
  end

  class AuthorizationError < StandardError
  end

end

require_relative 'smartsend/order'
require_relative 'smartsend/orders'
require_relative 'smartsend/address'
require_relative 'smartsend/receiver'
require_relative 'smartsend/sender'
require_relative 'smartsend/agent'
require_relative 'smartsend/service'
require_relative 'smartsend/parcel'
require_relative 'smartsend/parcel_item'
require_relative 'smartsend/client'
require_relative 'smartsend/account'
require_relative 'smartsend/version'
