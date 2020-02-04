# frozen_string_literal: true

module ApiCheck
  class Twitter < ApiCheck::Base
    private

    def cache_key
      :twitter
    end

    def url
      'https://takehome.io/twitter'
    end
  end
end
