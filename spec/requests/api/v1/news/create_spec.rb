# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'News', type: :request do
  let(:user) { create(:normal_user) }
  let(:user_id) { user.id }
  let(:token) { Authenticable.encode(user_id: user_id) }

  describe 'POST /news without Auth Token' do
    it 'returns Unauthorized without Token' do
      news = build(:good_news)
      post '/news', params: { news: news.attributes }
      # :unauthorized = 401
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'POST /news with Auth Token:' do
    it 'returns unprocessable_entity with empty news' do
      news = build(:bad_news)
      post '/news', params: { news: news.attributes },
                    headers: { 'Authorization' => "Bearer #{token}" },
                    as: :json
      # :unprocessable_entity = 422
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'with good data returns created' do
      news = build(:good_news)
      post '/news', params: { news: news.attributes },
                    headers: { 'Authorization' => "Bearer #{token}" },
                    as: :json
      # :created = 201
      expect(response).to have_http_status(:created)
    end
  end
end
