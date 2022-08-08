# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Categories', type: :request do
  let(:login_user) do
    create(:user, password: 'password')
    post api_v1_auth_login_path,
         params: { user: { email: User.last.email, password: 'password' } }, as: :json
    JSON.parse(response.body, symbolize_names: true)
  end

  let(:valid_headers) { { Authorization: login_user[:token] } }
  let(:valid_attributes) { build(:category) }
  let(:invalid_attributes) { build(:category, name: '') }

  describe 'GET /index' do
    before { create_list :category, 3 }

    it 'renders a successful response' do
      get api_v1_categories_path, headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    it 'renders three registers from database' do
      get api_v1_categories_path, headers: valid_headers, as: :json
      response_hash = JSON.parse(response.body, symbolize_names: true)
      expect(response_hash[:data].size).to eq(Category.all.size)
    end
  end

  describe 'GET /show' do
    it 'renders a succesful response' do
      category = create(:category)
      get api_v1_categories_path(category), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new category' do
        expect do
          post api_v1_categories_path, params: valid_attributes, headers: valid_headers, as: :json
        end.to change(Category, :count).by(1)
      end

      it 'renders a JSON response with the new category' do
        post api_v1_categories_path,
             params: valid_attributes, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json; charset=utf-8'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new category' do
        expect do
          post api_v1_categories_path,
               params: { category: invalid_attributes }, as: :json
        end.not_to change(Category, :count)
      end

      it 'renders a JSON response with errors for the new category' do
        post api_v1_categories_path,
             params: { category: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { description: 'A new description' }
      end

      it 'updates the requested category' do
        category = create(:category)
        patch api_v1_category_path(category),
              params: { category: new_attributes }, headers: valid_headers, as: :json
        # category.reload
        # skip('Add assertions for updated state')
        expect(response).to have_http_status(:ok)
      end

      it 'renders a JSON response with the category' do
        category = create(:category)
        patch api_v1_category_path(category),
              params: { category: new_attributes }, headers: valid_headers, as: :json
        # expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json; charset=utf-8'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the category' do
        category = create(:category)
        patch api_v1_category_path(category),
              params: { category: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested category' do
      category = create(:category)
      expect do
        delete api_v1_category_path(category), headers: valid_headers, as: :json
      end.to change(Category, :discarded)
      expect(response).to have_http_status(:no_content)
    end
  end
end
