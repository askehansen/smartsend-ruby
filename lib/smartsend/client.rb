require 'http'

class Smartsend::Client

  BASE_URL = 'http://smartsend-prod.apigee.net/v7/booking'.freeze

  def post(path, params)
    response = http.post("#{BASE_URL}/#{path}", json: params)
    response = JSON.parse(response)

    Rails.logger.debug(response) if defined?(Rails)

    response
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
