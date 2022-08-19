# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Testimonials', type: :request do
  let(:login_user) do
    create(:user, email: 'test@mail.com', password: 'password')
    post api_v1_auth_login_path,
         params: { user: { email: 'test@mail.com', password: 'password' } }, as: :json
    JSON.parse(response.body, symbolize_names: true)
  end

  let(:valid_headers) { { Authorization: login_user[:token] } }
  let(:valid_attributes) { build(:testimonial) }
  let(:invalid_attributes) { build(:testimonial, name: '') }

  describe 'GET /index' do
    let(:testimonials) { create_list(:testimonial, 3) }

    it 'renders a successful response' do
      get api_v1_testimonials_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    it 'renders three registers from database' do
      get api_v1_testimonials_url, headers: valid_headers, as: :json
      response_hash = JSON.parse(response.body, symbolize_names: true)
      expect(response_hash[:data].size).to eq(Testimonial.all.size)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new testimonial' do
        expect do
          post api_v1_testimonials_url,
               params: { testimonial: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Testimonial, :count).by(1)
      end

      it 'returns http status created' do
        post api_v1_testimonials_url,
             params: { testimonial: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
      end

      it 'returns a response of type JSON' do
        post api_v1_testimonials_url,
             params: { testimonial: valid_attributes }, headers: valid_headers, as: :json
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new testimonial' do
        expect do
          post api_v1_testimonials_url,
               params: { testimonial: invalid_attributes }, as: :json
        end.not_to change(Testimonial, :count)
      end

      it 'returns an http status unprocessable entity' do
        post api_v1_testimonials_url,
             params: { testimonial: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders a JSON response with errors for the new testimonial' do
        post api_v1_testimonials_url,
             params: { testimonial: invalid_attributes }, headers: valid_headers, as: :json
        expect(response.content_type).to include('application/json')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        build(:testimonial, content: 'A new testimonial')
      end

      it 'updates the requested testimonial' do
        testimonial = create(:testimonial)
        patch api_v1_testimonial_url(testimonial),
              params: { testimonial: new_attributes }, headers: valid_headers, as: :json
        testimonial.reload
      end

      it 'renders a JSON response with the testimonial' do
        testimonial = create(:testimonial)
        patch api_v1_testimonial_url(testimonial),
              params: { testimonial: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json; charset=utf-8'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the testimonial' do
        testimonial = create(:testimonial)
        patch api_v1_testimonial_url(testimonial),
              params: { testimonial: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:testimonial) { create(:testimonial) }

    it 'destroys the requested testimonial' do
      expect do
        delete api_v1_testimonial_path(testimonial), headers: valid_headers, as: :json
      end.to change(Testimonial, :discarded)
      expect(response).to have_http_status(:no_content)
    end
  end
end
