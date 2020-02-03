class SocialNetworksSerializer
  attr_reader :social_networks_checker

  def self.serialize(social_networks_checker)
    new(social_networks_checker).serialize
  end

  def initialize(social_networks_checker)
    @social_networks_checker = social_networks_checker
  end

  def serialize
    { twitter: [social_networks_checker.twitter_result.to_a], 
      facebook: [social_networks_checker.facebook_result.to_a],
      instagram: [social_networks_checker.instagram_result.to_a] }
  end
end
