# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Members', type: :request do
  before do
    ENV['JWT_SECRET_KEY'] = 'secret_key'
  end

  let(:login_user) do
    create(:user, password: 'password')
    post api_v1_auth_login_path,
         params: { user: { email: User.last.email, password: 'password' } }, as: :json
    JSON.parse(response.body, symbolize_names: true)
  end

  let(:valid_headers) { { Authorization: login_user[:token] } }

  let(:valid_attributes) { build(:member) }

  let(:invalid_attributes) { build(:member, name: 123_456) }

  describe 'GET /index' do
    before { create_list :member, 3 }

    it 'renders a successful response' do
      get api_v1_members_path, headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    it 'renders three registers from database' do
      get api_v1_members_path, headers: valid_headers, as: :json
      response_hash = JSON.parse(response.body, symbolize_names: true)
      expect(response_hash[:data].size).to eq(Member.all.size)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new member' do
        expect do
          post api_v1_members_path, params: valid_attributes, headers: valid_headers, as: :json
        end.to change(Member, :count).by(1)
      end

      it 'renders a JSON response with the new member' do
        post api_v1_members_path,
             params: valid_attributes, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json; charset=utf-8'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new member' do
        expect do
          post api_v1_members_path,
               params: { member: invalid_attributes }, as: :json
        end.not_to change(Member, :count)
      end

      it 'renders a JSON response with errors for the new member' do
        post api_v1_members_path,
             params: { member: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PUT /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        build(:member, description: 'A new description')
      end

      it 'updates the requested member' do
        member = create(:member)
        put api_v1_member_path(member),
            params: { member: new_attributes }, headers: valid_headers, as: :json
        member.reload
      end

      it 'renders a JSON response with the member' do
        member = create(:member)
        put api_v1_member_path(member),
            params: { member: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json; charset=utf-8'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the member' do
        member = create(:member, name: 123_456)
        put api_v1_member_path(member),
            params: invalid_attributes, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:member) { create(:member) }

    it 'destroys the requested member' do
      expect do
        delete api_v1_member_path(member), headers: valid_headers, as: :json
      end.to change(Member, :discarded)
      expect(response).to have_http_status(:no_content)
    end
  end
end
