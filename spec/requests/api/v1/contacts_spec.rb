# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Contacts', type: :request do
  before do
    ENV['JWT_SECRET_KEY'] = 'secret_key'
  end

  let(:login_user) do
    create(:user, password: 'password')
    post api_v1_auth_login_path,
         params: { user: { email: User.last.email, password: 'password' } }, as: :json
    JSON.parse(response.body, symbolize_names: true)
  end
end

let(:valid_headers) { { Authorization: login_user[:token] } }

let(:valid_attributes) { build(:member) }

let(:invalid_attributes) { build(:member, name: 123_456) }

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

  describe 'PUT /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        build(:contact, name: 'New name')
      end

      it 'updates the requested contact' do
        member = create(:contact)
        put api_v1_contact_path(contact),
            params: { contact: new_attributes }, headers: valid_headers, as: :json
        contact.reload
      end

      it 'renders a JSON response with the contact' do
        contact = create(:contact)
        put api_v1_contact_path(contact),
            params: { contact: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json; charset=utf-8'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the contact' do
        contact = create(:contact)
        put api_v1_contact_path(contact),
            params: invalid_attributes, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:contact) { create(:contact) }

    it 'destroys the requested contact' do
      expect do
        delete api_v1_contact_path(contact), headers: valid_headers, as: :json
      end.to change(Contact, :discarded)
      expect(response).to have_http_status(:no_content)
    end
  end
end
