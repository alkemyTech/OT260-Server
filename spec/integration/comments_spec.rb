# frozen_string_literal: true

require 'swagger_helper'

describe 'Comments API' do
  let(:login_user) do
    create(:user, password: 'password')
    post api_v1_auth_login_path,
         params: { user: { email: User.last.email, password: 'password' } }, as: :json
    JSON.parse(response.body, symbolize_names: true)
  end

  let(:Authorization) { login_user[:token] }

  let(:news) { create(:news) }
  let(:comment) { create(:comment) }

  path '/api/v1/comments' do
    get('Get All Comments') do
      response(200, 'successful') do
        tags 'Comments'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string
        schema type: :object,
               properties: {
                 comments: {
                   type: :array,
                   items: {
                     properties: {
                       body: { type: :string }
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

    post('Create Comment') do
      response(201, 'created') do
        tags 'Comments'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string
        parameter name: :comment, in: :body, schema: {
          type: :object,
          properties: {
            body: { type: :string, example: 'body-comment' },
            news_id: { type: :integer, example: 1 },
            user_id: { type: :integer, example: 1 }
          },
          required: %w[body]
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

  path '/api/v1/comments/{id}' do
    put('Update Comment') do
      response(200, 'updated successfully') do
        let(:id) { '2' }
        tags 'Comments'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string
        parameter name: :id, in: :path, type: :string
        parameter name: :comment, in: :body, schema: {
          type: :object,
          properties: {
            body: { type: :string, example: 'body-comment' }
          },
          required: %w[body]
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

    delete('Delete Comment') do
      response(200, 'deleted successfully') do
        let(:id) { 1 }
        tags 'Comments'
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
