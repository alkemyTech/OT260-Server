# frozen_string_literal: true

# spec/integration/blogs_spec.rb
require 'swagger_helper'

describe 'Activities API' do
  let(:login_user) do
    create(:user, password: 'password')
    post api_v1_auth_login_path,
         params: { user: { email: User.last.email, password: 'password' } }, as: :json
    JSON.parse(response.body, symbolize_names: true)
  end

  let(:Authorization) { login_user[:token] }

  let(:activity) { create(:activity) }

  path '/api/v1/activities' do
    post('Create Activity') do
      response(201, 'created') do
        tags 'Activities'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string
        parameter name: :activity, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            content: { type: :string }
          },
          required: %w[name content]
        }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end
    end
  end

  path '/api/v1/activities/{id}' do
    put('Update Activity') do
      response(200, 'updated successfully') do
        let(:id) { '123' }
        tags 'Activities'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string
        parameter name: :id, in: :path, type: :string
        parameter name: :activity, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            content: { type: :string }
          }
        }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end
    end
  end
end
