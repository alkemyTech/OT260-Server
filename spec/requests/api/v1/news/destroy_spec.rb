# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'News', type: :request do
  let(:news) { create(:good_news) }
  let(:user) { create(:normal_user) }
  let(:user_id) { user.id }
  let(:token) { Authenticable.encode(user_id: user_id) }

  describe 'DELETE /news/{id} without Token' do
    it 'returns Unauthorized' do
      delete "/news/#{news.id}"
      # :unauthorized = 401
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'DELETE /news/{id} with Token' do
    it 'delete successfully the news' do
      delete "/news/#{news.id}", headers: { 'Authorization' => "Bearer #{token}" }
      # :ok = 200
      expect(response).to have_http_status(:ok)
    end

    it 'returns 404 not found' do
      delete '/news/1000', headers: { 'Authorization' => "Bearer #{token}" }
      # :not_found = 404
      expect(response).to have_http_status(:not_found)
    end
  end
end
