# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Contacts', type: :request do
  let(:login_user) do
    create(:user, password: 'password')
    post api_v1_auth_login_path,
         params: { user: { email: User.last.email, password: 'password' } }, as: :json
    JSON.parse(response.body, symbolize_names: true)
  end

  let(:valid_headers) { { Authorization: login_user[:token] } }

  let(:valid_attributes) { build(:contact) }

  let(:invalid_attributes) { build(:contact, name: nil) }

  describe 'GET /index' do
    it 'renders a successful response' do
      get api_v1_contacts_path, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new contact' do
        expect do
          post api_v1_contacts_path, params: valid_attributes, headers: valid_headers, as: :json
        end.to change(Contact, :count).by(1)
      end

      it 'renders a JSON response with the new contact' do
        post api_v1_contacts_path,
             params: valid_attributes, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json; charset=utf-8'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new contact' do
        expect do
          post api_v1_contacts_path,
               params: { contact: invalid_attributes }, as: :json
        end.not_to change(Contact, :count)
      end

      it 'renders a JSON response with errors for the new contact' do
        post api_v1_contacts_path,
             params: { contact: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end
end
