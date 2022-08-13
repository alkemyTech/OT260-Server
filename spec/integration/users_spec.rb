# frozen_string_literal: true

require 'swagger_helper'

describe 'Users API' do
  let(:login_user) do
    create(:user, password: 'password')
    post api_v1_auth_login_path,
         params: { user: { email: User.last.email, password: 'password' } }, as: :json
    JSON.parse(response.body, symbolize_names: true)
  end

  let(:Authorization) { login_user[:token] }

  let(:user) { create(:user, password: 'password1') }

  path '/api/v1/users' do
    get('Get All Users') do
      response(200, 'successful') do
        tags 'Users'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string
        schema type: :object,
               properties: {
                 users: {
                   type: :array,
                   items: {
                     properties: {
                       id: { type: :integer },
                       email: { type: :string },
                       first_name: { type: :string },
                       last_name: { type: :string },
                       image: { type: :string }
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
  end

  path '/api/v1/auth/me' do
    get('Get My User') do
      response(200, 'successful') do
        tags 'Users'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string
        schema type: :object,
               properties: {
                 users: {
                   type: :array,
                   items: {
                     properties: {
                       id: { type: :integer },
                       email: { type: :string },
                       first_name: { type: :string },
                       last_name: { type: :string },
                       role: { type: :object,
                               items: {
                                 id: { type: :integer },
                                 name: { type: :string },
                                 description: { type: :string }
                               } },
                       image: { type: :string }
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
  end

  path '/api/v1/auth/register' do
    post('Register As User') do
      response(201, 'created') do
        tags 'Users'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
            user: {
              properties: {
                email: { type: :string },
                first_name: { type: :string },
                last_name: { type: :string },
                role_id: { type: :integer },
                password: { type: :string }
              }
            }
          },
          required: %w[email first_name last_name]
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

  path '/api/v1/auth/login' do
    post('Login As User') do
      response(200, 'successful') do
        tags 'Users'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
            user: {
              properties: {
                email: { type: :string },
                password: { type: :string }
              }
            }
          },
          required: %w[email password]
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

  path '/api/v1/users/{id}' do
    put('Update User') do
      response(200, 'updated successfully') do
        tags 'Users'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string
        parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
            user: {
              properties: {
                email: { type: :string },
                first_name: { type: :string },
                last_name: { type: :string },
                password: { type: :string }
              }
            }
          },
          required: %w[email first_name last_name]
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

    delete('Delete User') do
      response(200, 'deleted successfully') do
        let(:id) { '1' }
        tags 'Users'
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
