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


end

require 'smartsend/order'
require 'smartsend/orders'
require 'smartsend/address'
require 'smartsend/receiver'
require 'smartsend/sender'
require 'smartsend/agent'
require 'smartsend/service'
require 'smartsend/parcel'
require 'smartsend/parcel_item'
require 'smartsend/client'
