require 'net/http'
require 'uri'
require 'json'

module RecaptchaHelper
  def self.valid_token?(token)
    # Get secret from env
    secret = ENV['RECAPTCHA_SECRET_KEY']

    uri = URI('https://www.google.com/recaptcha/api/siteverify')
    request = Net::HTTP::Post.new(uri)
    request.set_form_data('secret' => secret, 'response' => token)
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |https|
      https.request(request)
    end

    # Check response
    json_body = JSON.parse(response.body)
    if json_body['success']
      true
    else
      false
    end
  end
end
