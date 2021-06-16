# frozen_string_literal: true

module RailsMiniProfiler
  class Badge
    include Engine.routes.url_helpers

    def initialize(profiled_request)
      @configuration = RailsMiniProfiler.configuration
      @profiled_request = profiled_request
      @original_response = @profiled_request.response
    end

    def render
      content_type = @original_response.headers['Content-Type']
      return @original_response unless content_type =~ %r{text/html}

      modified_response = Rack::Response.new([], @original_response.status, @original_response.headers)
      modified_response.write(modified_body)
      modified_response.finish

      response = @original_response.response
      response.close if response.respond_to?(:close)

      Response.new(status: @original_response.status,
                   headers: @original_response.headers,
                   response: modified_response)
    end

    private

    def modified_body
      body = @original_response.response.body
      index = body.rindex(%r{</body>}i) || body.rindex(%r{</html>}i)
      if index
        body.insert(index, badge_content)
      else
        body
      end
    end

    def badge_content
      html = IO.read(File.expand_path('../../app/views/rails_mini_profiler/badge.html.erb', __dir__))
      template = ERB.new(html)
      template.result(binding)
    end
  end
end