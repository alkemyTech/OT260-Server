# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/comments', type: :request do
  path '/api/v1/comments' do
    get('list comments') do
      response(200, 'successful') do
        tags 'Comments'
        consumes 'application/json'
        security [Bearer: {}]

        parameter name: 'Authorization', in: :header, type: :string

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

    post('create comment') do
      response(200, 'successful') do
        tags 'Comments'
        consumes 'application/json'
        security [Bearer: {}]

        parameter name: 'Authorization', in: :header, type: :string

        parameter name: :comment, in: :body, schema: {
          type: :object,
          properties: {
            body: { type: :string },
            user_id: { type: :integer },
            news_id: { type: :integer }
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
    # You'll want to customize the parameter types...

    parameter name: 'id', in: :path, type: :integer, description: 'comment id'

    put('update comment') do
      response(200, 'successful') do
        tags 'Comments'
        consumes 'application/json'
        security [Bearer: {}]

        parameter name: 'Authorization', in: :header, type: :string

        parameter name: :comment, in: :body, schema: {
          type: :object,
          properties: {
            body: { type: :string },
            user_id: { type: :integer },
            news_id: { type: :integer }
          },
          required: %w[body]
        }

        let(:id) { '123' }

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

    delete('delete comment') do
      response(200, 'successful') do
        tags 'Comments'
        consumes 'application/json'
        security [Bearer: {}]

        parameter name: 'Authorization', in: :header, type: :string
        let(:id) { '123' }

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
