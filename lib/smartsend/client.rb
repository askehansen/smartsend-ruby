require 'http'

class Smartsend::Client

  BASE_URL = 'http://smartsend-prod.apigee.net/v7/booking'.freeze

  def post(path, params)
    request do
      http.post("#{BASE_URL}/#{path}", json: params)
    end
  end

  def request
    response = yield

    Rails.logger.debug(response.to_s) if defined?(Rails)

    if /^2/ === response.code.to_s
      Response.new(JSON.parse(response)).successful!
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
    raise Smartsend::MissingConfigError, 'Missing email' if Smartsend.email.nil?
    raise Smartsend::MissingConfigError, 'Missing license' if Smartsend.license.nil?

    HTTP.headers(
      apikey: Smartsend.api_key,
      smartsendmail: Smartsend.email,
      smartsendlicence: Smartsend.license,
      cmssystem: Smartsend.cms_system,
      cmsversion: Smartsend.cms_version,
      appversion: Smartsend.app_version,
      test: Smartsend.test?
    )
  end

end
