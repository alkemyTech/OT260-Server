# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Activities', type: :request do
  let(:login_user) do
    create(:user, password: 'password')
    post api_v1_auth_login_url,
         params: { user: { email: User.last.email, password: 'password' } }, as: :json
    JSON.parse(response.body, symbolize_names: true)
  end

  let(:valid_headers) { { Authorization: login_user[:token] } }
  let(:valid_attributes) { build(:activity) }
  let(:invalid_attributes) { build(:activity, name: '') }
  let(:activities) { Activity.kept }

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new activity' do
        expect do
          post api_v1_activities_url,
               params: { activity: valid_attributes }, headers: valid_headers, as: :json
        end.to change(activities, :count).by(1)
      end

      it 'renders a JSON response with the new activity' do
        post api_v1_activities_url,
             params: { activity: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new activity' do
        expect do
          post api_v1_activities_url,
               params: { activity: invalid_attributes }, headers: valid_headers, as: :json
        end.not_to change(activities, :count)
      end

      it 'renders a JSON response with errors for the new activity' do
        post api_v1_activities_url,
             params: { activity: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        build(:activity, name: 'New name')
      end

      it 'updates the requested activity' do
        activity = create(:activity)
        patch api_v1_activity_url(activity),
              params: { activity: new_attributes }, headers: valid_headers, as: :json
        activity.reload
        expect(activity.name).to eq(new_attributes.name)
      end

      it 'renders a JSON response with the activity' do
        activity = create(:activity)
        patch api_v1_activity_url(activity),
              params: { activity: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the activity' do
        activity = create(:activity)
        patch api_v1_activity_url(activity),
              params: { activity: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end
end
