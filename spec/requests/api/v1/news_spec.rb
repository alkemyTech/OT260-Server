# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::News', type: :request do
  let(:login_user) do
    create(:user, password: 'password')
    post api_v1_auth_login_path,
         params: { user: { email: User.last.email, password: 'password' } }, as: :json
    JSON.parse(response.body, symbolize_names: true)
  end

  let(:valid_headers) { { Authorization: login_user[:token] } }

  let(:valid_attributes) { build(:news) }

  let(:invalid_attributes) { build(:news, name: 123_456) }

  describe 'GET /index' do
    before { create_list :news, 3 }

    it 'renders a successful response' do
      get api_v1_news_index_path, headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    it 'renders three registers from database' do
      get api_v1_news_index_path, headers: valid_headers, as: :json
      response_hash = JSON.parse(response.body, symbolize_names: true)
      expect(response_hash[:data].size).to eq(News.all.size)
    end
  end

  describe 'GET /show' do
    it 'renders a succesful response' do
      news = create(:news)
      get api_v1_news_path(news), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'create news' do
        expect do
          post api_v1_news_index_path, params: valid_attributes, headers: valid_headers, as: :json
        end.to change(News, :count).by(1)
      end

      it 'renders a JSON response with the news' do
        post api_v1_news_index_path,
             params: valid_attributes, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json; charset=utf-8'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a news' do
        expect do
          post api_v1_news_index_path,
               params: { news: invalid_attributes }, as: :json
        end.not_to change(News, :count)
      end

      it 'renders a JSON response with errors for the news' do
        post api_v1_news_index_path,
             params: { news: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PUT /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        build(:news, content: 'New content')
      end

      it 'updates the requested news' do
        news = create(:news)
        put api_v1_news_path(news),
            params: { news: new_attributes }, headers: valid_headers, as: :json
        news.reload
      end

      it 'renders a JSON response with the newss' do
        news = create(:news)
        put api_v1_news_path(news),
            params: { news: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json; charset=utf-8'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the newss' do
        news = create(:news, name: 123_456)
        put api_v1_news_path(news),
            params: invalid_attributes, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:news) { create(:news) }

    it 'destroys the requested news' do
      expect do
        delete api_v1_news_path(news), headers: valid_headers, as: :json
      end.to change(News, :discarded)
      expect(response).to have_http_status(:ok)
    end
  end
end
