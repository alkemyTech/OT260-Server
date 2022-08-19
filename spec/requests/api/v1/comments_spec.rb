# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'api/v1/comments', type: :request do
  before do
    ENV['JWT_SECRET_KEY'] = 'secret_key'
  end

  let(:user) { create(:user, email: 'fernando@gmail.com', password: 'password') }
  let(:login_user) do
    post api_v1_auth_login_url,
         params: { user: { email: 'fernando@gmail.com', password: 'password' } }, as: :json
    JSON.parse(response.body, symbolize_names: true)
  end

  let(:news) { create(:news) }
  let(:valid_headers) { { Authorization: login_user[:token] } }
  let(:valid_attributes) { build(:comment, user: user) }
  let(:invalid_attributes) { build(:comment, user: user, body: '') }

  describe 'GET /index' do
    before { create_list :comment, 3, user: user, news: news }

    it 'renders a successful response' do
      get api_v1_comments_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    it 'renders three registers from database' do
      get api_v1_comments_url, headers: valid_headers, as: :json
      response_hash = JSON.parse(response.body, symbolize_names: true)
      expect(response_hash[:data].size).to eq(Comment.all.size)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new comment' do
        expect do
          post api_v1_comments_url,
               params: { comment: valid_attributes, news_id: news.id }, headers: valid_headers, as: :json
        end.to change(Comment, :count).by(1)
      end

      it 'returns http status created' do
        post api_v1_comments_url,
             params: { comment: valid_attributes, news_id: news.id }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
      end

      it 'returns a response of type JSON' do
        post api_v1_comments_url,
             params: { comment: valid_attributes, news_id: news.id }, headers: valid_headers, as: :json
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new comment' do
        expect do
          post api_v1_comments_url,
               params: { comment: invalid_attributes }, as: :json
        end.not_to change(Comment, :count)
      end

      it 'returns an http status unprocessable entity' do
        post api_v1_comments_url,
             params: { comment: invalid_attributes, news_id: news.id }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders a JSON response with errors for the new comment' do
        post api_v1_comments_url,
             params: { comment: invalid_attributes, news_id: news.id }, headers: valid_headers, as: :json
        expect(response.content_type).to include('application/json')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        build(:comment)
      end

      it 'updates the requested comment' do
        comment = create(:comment, user: user)
        patch api_v1_comment_url(comment),
              params: { comment: new_attributes, news_id: news.id }, headers: valid_headers, as: :json
        comment.reload
      end

      it 'renders a JSON response with the comment' do
        comment = create(:comment, user: user)
        patch api_v1_comment_url(comment),
              params: { comment: new_attributes, news_id: news.id }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json; charset=utf-8'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the comment' do
        comment = create(:comment, user: user)
        patch api_v1_comment_url(comment),
              params: { comment: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested comment' do
      comment = create(:comment, user: user)
      expect do
        delete api_v1_comment_path(comment), headers: valid_headers, as: :json
      end.to change(Comment, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
