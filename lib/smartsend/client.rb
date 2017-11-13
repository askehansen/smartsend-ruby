require 'http'

class Smartsend::Client

  BASE_URL = 'https://smartsend-prod.apigee.net/v7/booking'.freeze

  def post(path, params)
    http.post(path, json: params)
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
      cmssystem: Smartsend.cmssystem,
      cmsversion: Smartsend.cmsversion,
      appversion: Smartsend.appversion,
      test: Smartsend.test?
    )
  end

end
