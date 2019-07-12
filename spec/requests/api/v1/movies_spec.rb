# frozen_string_literal: true

require "rails_helper"

describe 'Movies Api', type: :request do
  let(:expected_attributes) { %w[id title] }

  describe 'GET api/v1/movies' do
    context 'without params' do
      let!(:movie) { create(:movie, title: "Kill Bill") }
      subject { get '/api/v1/movies' }

      before { subject }

      it 'returns movies' do
        expect(response).to have_http_status(200)
        expect(parsed_body['data'].count).to eq 1
        expect(parsed_body['data'].first).to have_attributes(*expected_attributes)
        expect(parsed_body['data'].first).to have_type('movies')
        expect(parsed_body['jsonapi']).to eq('version' => '1.0')
      end
    end
  end

  describe 'GET api/v1/movies' do
    context 'without params' do
      let!(:movie) { create(:movie, title: "Kill Bill") }
      subject { get "/api/v1/movies/#{movie.id}" }

      before { subject }

      it 'returns movie' do
        expect(response).to have_http_status(200)
        expect(parsed_body['data']).to have_attributes(*expected_attributes)
        expect(parsed_body['data']).to have_type('movies')
      end
    end
  end
end
