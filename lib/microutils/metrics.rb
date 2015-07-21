require 'em-http-request'
require 'keen'

Thread.new { EventMachine.run }

module Metrics

  # TODO attr_accessor to define when to sent metrics

  # TODO auto append data

  # TODO sensitive data filter

  # TODO timer object that can be stopped upon completion to trigger event send

  # TODO unify EM with rails logger
  def self.track_in(queue, data={}, &block)
    data = data.to_h
    if block_given?
      block_result = nil
      ms = Time.measure do
        block_result = block.call
      end
      data[:duration_ms] = ms
    end
    http = Keen.publish_async queue.to_s, data
    http.callback { |response| $logger.info "Keen event successfuly sent to collection=#{queue}"}
    http.errback { $logger.error "Failed to track event in collection=#{queue}"}
    return block_result if block_given?
  end
end