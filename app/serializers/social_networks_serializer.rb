# frozen_string_literal: true

class SocialNetworksSerializer
  attr_reader :social_networks_checker

  def self.serialize(social_networks_checker)
    new(social_networks_checker).serialize
  end

  def initialize(social_networks_checker)
    @social_networks_checker = social_networks_checker
  end

  def serialize
    { twitter: array_result(social_networks_checker.twitter_result),
      facebook: array_result(social_networks_checker.facebook_result),
      instagram: array_result(social_networks_checker.instagram_result) }
  end

  private

  def array_result(result)
    result.to_a
  rescue StandardError
    []
  end
end
