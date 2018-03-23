require 'http'
require 'logger'

class Smartsend::Client

  def initialize(account=nil)
    @account = account || Smartsend.account
  end

  def post(path, params)
    request do
      http.post(url(path), json: params)
    end
  end

  def get(path)
    request do
      http.get(url(path))
    end
  end

  def get_plain(path)
    http.get(url(path))
  end

  def request
    response = yield

    logger.debug(response)
    logger.debug(response.body.to_s)

    case response.code
    when (200..299)
      Response.new(JSON.parse(response)).successful!(response.code)
    when 401
      raise Smartsend::AuthorizationError, 'Unable to authorize'
    when 404
      raise Smartsend::NotFoundError, 'Resource not found'
    else
      Response.new(JSON.parse(response)).failed!(response.code)
    end
  end

  class Response < SimpleDelegator
    attr_reader :http_code

    def successful!(http_code)
      @http_code = http_code
      @success = true
      self
    end

    def failed!(http_code)
      @http_code = http_code
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

  BASE_URL = 'http://smartsend-test.apigee.net/api/v1'.freeze

  def url(path)
    "#{BASE_URL}/#{path}?api_token=#{@account.api_token}"
  end

  def logger
    Logger.new($stdout)
  end

  def http
    raise Smartsend::MissingConfigError, 'Missing api_token' if @account.api_token.nil?

    HTTP.headers({
      accept: 'application/json'
    })
  end

end
