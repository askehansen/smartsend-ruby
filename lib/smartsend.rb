module Smartsend

  def self.configure(args={})
    args.each do |k, v|
      class_variable_set "@@#{k}", v
    end
  end

  def self.hi
    "hi"
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

  def self.cmssystem
    @@cmsversion
  end

  def self.cmsversion
    @@cmsversion
  end

  def self.appversion
    @@appversion
  end

  def self.test_mode
    @@test_mode
  end

  def self.test?
    test_mode
  end


  class TooManyOrdersError < StandardError
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
