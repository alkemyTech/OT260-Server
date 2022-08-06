require 'rails_helper'

RSpec.describe 'Api::V1::api_v1_Categories', type: :request do

  before do
    ENV['JWT_SECRET_KEY'] = 'secret'
  end
  
  let!(:user) {  create(:user, email: 'fernando@gmail.com', password: 'password') }
  let(:login_user) do
    #create(:user, password: 'password')
    post api_v1_auth_login_url,
      params: { user: { email: User.last.email, password: 'password' } }, as: :json
    respond_has = JSON.parse(response.body, symbolize_names: true)
  end

  let(:valid_headers) { { Authorization: login_user[:token] } }
  let(:valid_attributes) { build(:category) }
  let(:invalid_attributes) { build(:category, name: 123_456) }
  let(:categories) { Category.kept }

  describe 'GET /index' do
    before { create_list :category, 3}

    it 'renders a succesful response' do
      get '/api/v1/categories', headers: valid_headers, as: :json
      expect(response).to be_succesful  
    end

    it 'renders three registers from database' do
      get '/api/v1/categories', headers: valid_headers, as: :json
      response_hash = JSON.parse(response.body, symbolize_names: true)
      expect(response_hash[:data].size).to eq(Category.all.size)
    end
  end

  describe 'GET /show' do
    it 'renders a succesful response' do
      category = create(:category)
      get api_v1_categories_url(category), as: :json
      expect(response).to be_succesful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new category' do
        expect do
          post api_v1_categories_url,
               params: { category: valid_attributes }, headers: valid_headers, as: :json
        end.to change(categories, :count).by(1)
      end

      it 'renders a JSON response with the new category' do
        post api_v1_categories_url,
             params: { category: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new category' do
        expect do
          post api_v1_categories_url,
               params: { category: invalid_attributes }, as: :json
        end.not_to change(categories, :count)
      end

      it 'renders a JSON response with errors for the new category' do
        post api_v1_categories_url,
             params: { category: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        build(:category, description: 'A new description')
      end

      it 'updates the requested category' do
        category = create(:category)
        patch api_v1_category_url(category),
          params: { category: new_attributes }, headers: valid_headers, as: :json
        category.reload
        skip('Add assertions for updated state')
      end

      it 'renders a JSON response with the category' do
        category = create(:category)
        patch category_url(category),
          params: { category: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))    
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the category' do
        category = create(:category)
        patch category_url(category),
          params: { category: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_hhtp_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))    
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested category' do
      category = create(:category)
      expect do
          delete category_url(category), headers: valid_headers, as: :json
      end.to change(category, :count).by(-1)
    end
  end
end
