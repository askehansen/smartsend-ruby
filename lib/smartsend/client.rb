require 'http'

class Smartsend::Client

  BASE_URL = 'http://smartsend-prod.apigee.net/v7'.freeze

  def initialize(account=nil)
    @account = account || Smartsend.account
  end

  def post(path, params)
    request do
      http.post("#{BASE_URL}/#{path}", json: params)
    end
  end

  def get(path)
    request do
      http.get("#{BASE_URL}/#{path}")
    end
  end

  def get_plain(path)
    http.get("#{BASE_URL}/#{path}")
  end

  def request
    response = yield

    Rails.logger.debug(response.to_s) if defined?(Rails)

    case response.code.to_s
    when '200'
      Response.new(JSON.parse(response)).successful!
    when '401'
      raise Smartsend::AuthorizationError, 'Unable to authorize'
    else
      Response.new(response).failed!
    end
  end

  class Response < SimpleDelegator

    def successful!
      @success = true
      self
    end

    def failed!
      @success = false
      self
    end

    def success?
      @success
    end

    def failed?
      !@success
    end

  end

  private

  def http
    raise Smartsend::MissingConfigError, 'Missing api_key' if Smartsend.api_key.nil?
    raise Smartsend::MissingConfigError, 'Missing email'   if @account.email.nil?
    raise Smartsend::MissingConfigError, 'Missing license' if @account.license.nil?

    HTTP.headers(
      apikey: Smartsend.api_key,
      smartsendmail: @account.email,
      smartsendlicence: @account.license,
      cmssystem: Smartsend.cms_system,
      cmsversion: Smartsend.cms_version,
      appversion: Smartsend.app_version,
      test: Smartsend.test?
    )
  end

end
