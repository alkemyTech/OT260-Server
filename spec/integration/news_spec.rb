# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Categories API' do
  let(:login_user) do
    create(:user, password: 'password')
    post api_v1_auth_login_path,
         params: { user: { email: User.last.email, password: 'password' } }, as: :json
    JSON.parse(response.body, symbolize_names: true)
  end

  let(:Authorization) { login_user[:token] }

  let(:news) { create(:news) }

  path '/api/v1/news' do
    get('Get All News') do
      response(200, 'succesful') do
        tags 'News'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string
        schema type: :object,
               properties: {
                 news: {
                   type: :array,
                   items: {
                     properties: {
                       content: { type: :text },
                       name: { type: :string },
                       news_type: {type: :string},
                       category_id: {type: :integer}
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

    post('Create News') do
      response(201, 'created') do
        tags 'News'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string
        parameter name: :News, in: :body, schema: {
          type: :object,
          properties: {
            content: { type: :text },
            name: { type: :string },
            news_type: {type: :string},
            category_id: {type: :integer}
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

  path '/api/v1/news/{id}' do
    get('Show News') do
      response(200, 'succesful') do
        let(:id) { '123' }
        tags 'News'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string
        parameter name: :id, in: :path, type: :string
        schema type: :object,
               properties: {
                 categories: {
                   type: :array,
                   items: {
                    properties: {
                        content: { type: :string },
                        name: { type: :string },
                        news_type: {type: :string},
                        category_id: {type: :integer}
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

    put('Update News') do
      response(200, 'updated successfully') do
        let(:id) { '123' }
        tags 'News'
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string
        parameter name: :id, in: :path, type: :string
        parameter name: :news, in: :body, schema: {
          type: :object,
          properties: {
            content: { type: :text },
            name: { type: :string },
            news_type: {type: :string},
            category_id: {type: :integer}
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

    delete('Delete News') do
      response(204, 'deleted') do
        let(:id) { '1' }
        tags 'News'
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
