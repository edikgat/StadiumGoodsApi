# frozen_string_literal: true

class Api::SocialNetworksApi < Grape::API
  format :json

  desc 'Loads latest information from social networks'
  get '' do
    SocialNetworksSerializer.serialize(
      SocialNetworksChecker.check)
  end
end
