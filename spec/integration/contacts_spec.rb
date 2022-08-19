# frozen_string_literal: true

# spec/integration/blogs_spec.rb
require 'swagger_helper'

describe 'Contacts API' do
  let(:login_user) do
    create(:user, password: 'password')
    post api_v1_auth_login_path,
         params: { user: { email: User.last.email, password: 'password' } }, as: :json
    JSON.parse(response.body, symbolize_names: true)
  end

  let(:Authorization) { login_user[:token] }

  let(:contact) { create(:contact) }

  path '/api/v1/contacts' do
    get('Get All Contacts') do
      response(200, 'successful') do
        tags 'Contacts'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string
        schema type: :object,
               properties: {
                 contacts: {
                   type: :array,
                   items: {
                     properties: {
                       id: { type: :integer },
                       name: { type: :string },
                       email: { type: :string },
                       phone: { type: :string, nullable: true },
                       message: { type: :text, nullable: true }
                     }
                   }
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

    post('Create Contact') do
      response(201, 'created') do
        tags 'Contacts'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string
        parameter name: :contact, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            email: { type: :string },
            phone: { type: :string, nullable: true },
            message: { type: :string, nullable: true }
          },
          required: %w[name email]
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
