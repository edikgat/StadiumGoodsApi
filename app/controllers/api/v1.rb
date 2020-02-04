# frozen_string_literal: true

require 'grape-swagger'

module Api
  class V1 < Grape::API
    format :json
    content_type :json, 'application/json; charset=UTF-8'
    default_format :json

    rescue_from Grape::Exceptions::ValidationErrors do |e|
      error_response(message: e.message, status: 422)
    end

    rescue_from StandardError do |e|
      error_response(message: e.message, status: 500)
    end

    helpers do
      def logger
        Rails.logger
      end
    end

    before do
      header 'Content-Type', 'application/json; charset=UTF-8'
    end

    mount Api::SocialNetworksApi

    add_swagger_documentation(
      api_version: 'v1',
      hide_documentation_path: true,
      mount_path: '/swagger_doc',
      hide_format: true,
      info: {
        title: 'Social Networks API',
        description: 'Concurrently Loads Information from Facebook, Instagram and Twitter',
        contact_name: 'Eduard Gataullin',
        contact_email: 'edikgat@gmail.com',
        license: 'MIT'
      }
    )
  end
end
