# frozen_string_literal: true

module ApiCheck
  class Instagram < ApiCheck::Base
    private

    def cache_key
      :instagram
    end

    def url
      'https://takehome.io/instagram'
    end
  end
end
