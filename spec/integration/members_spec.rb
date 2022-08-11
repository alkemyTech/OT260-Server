# frozen_string_literal: true

# spec/integration/blogs_spec.rb
require 'swagger_helper'

describe 'Members API' do
  let(:login_user) do
    create(:user, password: 'password')
    post api_v1_auth_login_path,
         params: { user: { email: User.last.email, password: 'password' } }, as: :json
    JSON.parse(response.body, symbolize_names: true)
  end

  let(:Authorization) { login_user[:token] }

  let(:member) { create(:member) }

  path '/api/v1/members' do
    get('Get All Members') do
      response(200, 'successful') do
        tags 'Members'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string
        schema type: :object,
               properties: {
                 members: {
                   type: :array,
                   items: {
                     properties: {
                       id: { type: :integer },
                       name: { type: :string },
                       facebook_url: { type: :string, nullable: true },
                       linkedin_url: { type: :string, nullable: true },
                       instagram_url: { type: :string, nullable: true },
                       description: { type: :string, nullable: true }
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

    post('Create Member') do
      response(201, 'created') do
        tags 'Members'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string
        parameter name: :member, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            facebook_url: { type: :string, nullable: true },
            linkedin_url: { type: :string, nullable: true },
            instagram_url: { type: :string, nullable: true },
            description: { type: :string, nullable: true }
          },
          required: %w[name]
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

  path '/api/v1/members/{id}' do
    put('Update Member') do
      response(200, 'updated successfully') do
        let(:id) { '123' }
        tags 'Members'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string
        parameter name: :id, in: :path, type: :string
        parameter name: :member, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            facebook_url: { type: :string, nullable: true },
            linkedin_url: { type: :string, nullable: true },
            instagram_url: { type: :string, nullable: true },
            description: { type: :string, nullable: true }
          },
          required: %w[name]
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

    delete('Delete Member') do
      response(200, 'deleted successfully') do
        let(:id) { '1' }
        tags 'Members'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string
        parameter name: :id, in: :path, type: :string

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
