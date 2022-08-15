# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'News', type: :request do
  let(:user) { create(:normal_user) }
  let(:user_id) { user.id }
  let(:token) { Authenticable.encode(user_id: user_id) }
  let(:good_news) { create(:good_news) }
  let(:bad_news) { create(:bad_news) }

  describe 'GET /news/{id}/details Without Token' do
    it 'returns http 401' do
      get "/news/#{good_news.id}/details"
      # unauthorized = 401
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET /news/{id}/details With Token' do
    it 'respond with 200' do
      get "/news/#{good_news.id}/details",
          headers: { 'Authorization' => "Bearer #{token}" },
          as: :json
      # ok = 200
      expect(response).to have_http_status(:ok)
    end

    it 'returns 404 not found' do
      get '/news/1000/details', headers: { 'Authorization' => "Bearer #{token}" }
      # not_found = 404
      expect(response).to have_http_status(:not_found)
    end
  end
end
