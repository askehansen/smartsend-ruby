class Smartsend::Label
  attr_accessor :tracking_code, :url, :pdf

  def self.find_by_tracking_code(tracking_code, account: nil)
    response = Smartsend::Client.new(account, debug: true).get("shipments/tracking/#{tracking_code}/labels")

    if response.success?
      label = new
      label.tracking_code = tracking_code
      label.url = response.dig('data', 'pdf', 'link')
      label.pdf = response.dig('data', 'pdf', 'base_64_encoded')
      label
    end
  end

end
