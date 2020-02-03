# frozen_string_literal: true

class Api::SocialNetworksApi < Grape::API
  version 'v1', using: :path
  prefix 'api'
  format :json

  resource :social_networks do
    desc 'Loads latest information from social networks'
    get '' do
      SocialNetworksSerializer.serialize(
        SocialNetworksChecker.check)
    end
  end
end
