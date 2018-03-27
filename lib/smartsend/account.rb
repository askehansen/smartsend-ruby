class Smartsend::Account
  attr_accessor :api_token, :referer, :user_agents

  def initialize(api_token:, referer: nil, user_agents: nil)
    @api_token = api_token
    @referer = referer
    @user_agents = user_agents
  end

  def valid?
    raise NotImplementedError
  end

end
