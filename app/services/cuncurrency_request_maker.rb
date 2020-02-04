# frozen_string_literal: true

class CuncurrencyRequestMaker
  attr_reader :result,
              :hydra,
              :url,
              :max_restarts,
              :concurrency_level,
              :restarts

  def initialize(url, max_restarts:, concurrency_level:)
    @url = url
    @hydra = Typhoeus::Hydra.new
    @restarts = 0
    @max_restarts = max_restarts
    @concurrency_level = concurrency_level
  end

  def process
    concurrency_level.times do
      hydra.queue(request { |respose| return respose })
    end
    hydra.run
    nil
  end

  private

  def request(&block)
    Typhoeus::Request.new(url, followlocation: true).tap do |req|
      req.on_complete do |response|
        if response.success?
          process_success(response, &block)
        else
          process_error(&block)
        end
      end
    end
  end

  def process_success(response, &block)
    parsed_response = parsed_response(response)
    if parsed_response
      result_mutex.synchronize do
        @result = parsed_response
        hydra.abort
        block.call(@result)
      end
    else
      process_error(&block)
    end
  end

  def process_error(&block)
    restart_counter_mutex.synchronize do
      if @restarts < max_restarts
        @restarts += 1
        hydra.queue(request(&block))
      end
    end
  end

  def parsed_response(response)
    JSON.parse(response.body)
  rescue StandardError
    nil
  end

  def restart_counter_mutex
    @restart_counter_mutex ||= Mutex.new
  end

  def result_mutex
    @result_mutex ||= Mutex.new
  end
end
