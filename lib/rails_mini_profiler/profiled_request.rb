# frozen_string_literal: true

module RailsMiniProfiler
  class ProfiledRequest
    include ActiveModel::Model

    attr_accessor :id,
                  :user,
                  :request,
                  :response,
                  :flamegraph

    attr_reader :start,
                :finish,
                :duration,
                :allocations,
                :traces

    delegate :status, to: :response
    delegate :body, to: :response, prefix: true

    delegate :path, to: :request
    delegate :headers, :body, to: :request, prefix: true

    def initialize(**kwargs)
      kwargs.each { |key, value| instance_variable_set("@#{key}", value) }
      @traces ||= []
    end

    def complete!
      total_time = traces.find { |trace| trace.name == 'rails_mini_profiler.total_time' }
      @start = total_time&.start
      @finish = total_time&.finish
      @duration = ((@finish - @start) * 1000).round
      @allocations = total_time.allocations
      @traces.sort_by!(&:start)
    end

    def to_h
      instance_variables.each_with_object({}) { |var, hash| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    end
  end
end