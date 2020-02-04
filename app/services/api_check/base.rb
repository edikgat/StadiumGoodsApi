# frozen_string_literal: true

module ApiCheck
  class Base
    EXPIRES_IN = 1.minute

    attr_reader :force, :request_maker

    def initialize(force:)
      @force = force
      @request_maker = CuncurrencyRequestMaker.new(url,
                                                   max_restarts: max_restarts,
                                                   concurrency_level: concurrency_level)
    end

    def result
      @result ||= in_cache do
        request_maker.process
      end
    end

    private

    def max_restarts
      30
    end

    def concurrency_level
      10
    end

    def in_cache
      Rails.cache.fetch(
        cache_key,
        expires_in: EXPIRES_IN,
        force: force,
        skip_nil: true
      ) do
        yield
      end
    end

    def cache_key
      raise NotImplementedError
    end

    def url
      raise NotImplementedError
    end
  end
end
