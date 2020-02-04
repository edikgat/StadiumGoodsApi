# frozen_string_literal: true

module Api
  class SocialNetworksApi < Grape::API
    format :json

    desc 'Loads latest information from social networks'
    get '' do
      status 200
      SocialNetworksSerializer.serialize(
        SocialNetworksChecker.check
      )
    end
  end
end
