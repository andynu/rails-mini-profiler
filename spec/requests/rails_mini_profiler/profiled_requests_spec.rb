# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

module RailsMiniProfiler
  RSpec.describe '/profiled_requests', type: :request do
    let(:valid_attributes) { { id: 1, duration: 10 } }

    let(:configuration) { RailsMiniProfiler.configuration }

    let(:context) { RailsMiniProfiler.context }

    let(:storage) { context.storage_instance }

    describe 'GET /index' do
      it 'renders a successful response' do
        storage.save(ProfiledRequest.new(valid_attributes))
        get profiled_requests_url
        expect(response).to be_successful
      end
    end

    describe 'GET /show' do
      it 'renders a successful response' do
        profiled_request = storage.save(ProfiledRequest.new(valid_attributes))
        get profiled_request_url(profiled_request.id)
        expect(response).to be_successful
      end
    end

    describe 'DELETE /destroy' do
      it 'destroys the requested profiled_request' do
        profiled_request = storage.save(ProfiledRequest.new(valid_attributes))
        delete profiled_request_url(profiled_request.id)

        expect(storage.find(profiled_request.id)).to be_nil
      end
    end
  end
end