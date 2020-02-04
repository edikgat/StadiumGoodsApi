# frozen_string_literal: true

module SocialApiStubHelper
  INSTAGRAM_URL = 'https://takehome.io/instagram'
  INSTAGRAM_RESPONSE = [{ 'username' => 'hipster1', 'picture' => 'food' },
                        { 'username' => 'hipster2', 'picture' => 'cat' }].freeze
  FACEBOOK_URL = 'https://takehome.io/facebook'
  FACEBOOK_RESPONSE = [{ 'name' => 'friend',
                         'status' => "Here's some photos" },
                       { 'name' => 'Drama',
                         'status' => 'I am in a hospital' }].freeze
  TWITTER_URL = 'https://takehome.io/twitter'
  TWITTER_RESPONSE = [{ 'username' => '@kaiser',
                        'tweet' =>
                        'If you live to be 100' },
                      { 'username' => '@mike',
                        'tweet' =>
                        'STOP' }].freeze

  def success_instagram_stub
    instagram_stub_for(INSTAGRAM_RESPONSE.to_json, 200)
  end

  def success_twitter_stub
    twitter_stub_for(TWITTER_RESPONSE.to_json, 200)
  end

  def success_facebook_stub
    facebook_stub_for(FACEBOOK_RESPONSE.to_json, 200)
  end

  def error_facebook_stub
    facebook_stub_for('no json error', 500)
  end

  def error_twitter_stub
    twitter_stub_for('no json error', 500)
  end

  def error_instagram_stub
    instagram_stub_for('no json error', 500)
  end

  def timeout_twitter_stub
    timeout_response_stub(TWITTER_URL)
  end

  def timeout_instagram_stub
    timeout_response_stub(INSTAGRAM_URL)
  end

  def timeout_facebook_stub
    timeout_response_stub(FACEBOOK_URL)
  end

  def facebook_stub_for(response_body, status_code)
    response_stub(FACEBOOK_URL, response_body, status_code)
  end

  def instagram_stub_for(response_body, status_code)
    response_stub(INSTAGRAM_URL, response_body, status_code)
  end

  def twitter_stub_for(response_body, status_code)
    response_stub(TWITTER_URL, response_body, status_code)
  end

  def response_stub(url, response_body, status_code)
    stub_request(:get, url)
      .to_return(status: status_code, body: response_body)
  end

  def timeout_response_stub(url)
    stub_request(:get, url)
      .to_timeout
  end
end

RSpec.configure do |config|
  config.include SocialApiStubHelper
end
