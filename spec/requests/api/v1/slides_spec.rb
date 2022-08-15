# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Api::V1::Slides', type: :request do
  let(:login_user) do
    create(:user, password: 'password')
    post api_v1_auth_login_url,
         params: { user: { email: User.last.email, password: 'password' } }, as: :json
    JSON.parse(response.body, symbolize_names: true)
  end
  let(:valid_headers) { { Authorization: login_user[:token] } }

  let(:valid_attributes) { build(:slide) }

  let(:organization) { create(:organization) }

  let(:invalid_attributes) { build(:slide, text: 213_142) }

  describe 'GET /index' do
    before { create_list :slide, 3 }

    it 'renders a successful response' do
      get api_v1_slides_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    it 'renders three registers from database' do
      get api_v1_slides_url, headers: valid_headers, as: :json
      response_hash = JSON.parse(response.body, symbolize_names: true)
      expect(response_hash[:data].size).to eq(Slide.all.size)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      before { create_list :organization, 3 }

      it 'creates a new slide' do
        expect do
          post api_v1_slides_url,
               params: { slides: valid_attributes,
                         organization_id: organization.id }, headers: valid_headers, as: :json
        end.to change(Slide, :count).by(1)
      end

      it 'renders a JSON response with the new slide' do
        post api_v1_slides_url,
             params: { slides: valid_attributes,
                       organization_id: organization.id }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end

      context 'with invalid parameters' do
        it 'does not create a new slide' do
          expect do
            post api_v1_slides_url,
                 params: { slide: invalid_attributes }, as: :json
          end.not_to change(Slide, :count)
        end

        it 'renders a JSON response with errors for the new slide' do
          post api_v1_slides_url,
               params: { slide: invalid_attributes }, headers: valid_headers, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to eq('application/json; charset=utf-8')
        end
      end
    end

    describe 'PATCH /update' do
      context 'with valid parameters' do
        let(:new_attributes) do
          build(:slide, organization_id: organization.id)
        end

        it 'updates the requested slide' do
          slide = create(:slide, text: 'new text')
          patch api_v1_slide_url(slide),
                params: { slide: new_attributes }, headers: valid_headers, as: :json
          slide.reload
        end

        it 'renders a JSON response with the slide' do
          slide = create(:slide, text: 'new text')
          patch api_v1_slide_url(slide),
                params: { slide: new_attributes }, headers: valid_headers, as: :json
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to match(a_string_including('application/json; charset=utf-8'))
        end
      end

      context 'with invalid parameters' do
        it 'renders a JSON response with errors for the slide' do
          slide = create(:slide)
          patch api_v1_slide_url(slide),
                params: { slide: invalid_attributes }, headers: valid_headers, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to eq('application/json; charset=utf-8')
        end
      end
    end

    describe 'DELETE /destroy' do
      it 'destroys the requested slide' do
        slide = create(:slide)
        expect do
          delete api_v1_slide_path(slide), headers: valid_headers, as: :json
        end.to change(Slide, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
